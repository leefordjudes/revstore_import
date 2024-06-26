use std::{fs, result::Result, time::Instant};

use sea_orm::ConnectionTrait;

//cargo run -- postgresql://postgres:1@localhost:5432/t1
#[tokio::main]
async fn main() -> Result<(), String> {
    let args: Vec<String> = std::env::args().collect();
    let db_url = args
        .get(1)
        .map(|x| x.to_string())
        .unwrap_or("postgresql://postgres:1@192.168.1.31:5432/testorg".to_owned());
    let db = sea_orm::Database::connect(db_url)
        .await
        .expect("Database connection failed");
    println!("data base connected");
    let s0 = Instant::now();
    let mut files: Vec<String> = Vec::new();
    let mut file_order: Vec<u16> = Vec::new();
    let mut file_paths: Vec<String> = Vec::new();

    match fs::read_dir("./data/") {
        Ok(dirs) => {
            for dir in dirs.flatten() {
                let path = dir.path().to_string_lossy().to_string();
                file_paths.push(path.clone());
                let order = (path.replace("./data/", "")[0..3].to_string())
                    .parse::<u16>()
                    .expect("Couldnot get file order");

                file_order.push(order);
            }
        }
        Err(_) => {
            return Err("could not read backup data folder".into());
        }
    }
    file_order.sort();
    for ord in file_order {
        let filepath = file_paths
            .iter()
            .find_map(|x| x.contains(&format!("/{:03}_", ord)).then_some(x.clone()))
            .unwrap_or_default()
            .to_string();
        if !filepath.is_empty() {
            match fs::read_to_string(&filepath) {
                Ok(file) => {
                    files.push(file);
                }
                Err(_) => {
                    return Err(format!("could not read file {}", &filepath));
                }
            }
        }
    }

    println!("\n Restore data started.\n");
    for f in files {
        let stmts = f.split("--##").collect::<Vec<&str>>();
        // println!("statements: {:?}", &stmts);
        for stmt in stmts {
            // println!("\nRunning:\n{}\n", &stmt);
            let _ = db
                .execute_unprepared(stmt)
                .await
                .map_err(|_| format!("Couldnot run script: {}", &stmt))?;
            // println!("\nCompleted\n");
        }
    }
    println!("\n Restore data completed.\n");
    println!("Elasped time: {} secs", s0.elapsed().as_secs());

    Ok(())
}
