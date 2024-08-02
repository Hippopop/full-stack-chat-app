import dotenv from "dotenv";
import { defineConfig } from "drizzle-kit";


dotenv.config({ path: "../../.env" });
export default defineConfig({
    dialect: "mysql",
    out: "./migrations",
    schema: "./schemas/*",
    migrations: {
        prefix: "timestamp",
    },
    dbCredentials: {
        user: process.env.SQL_USER!,
        host: process.env.SQL_HOST!,
        database: process.env.DATABASE_NAME!,
        port: parseInt(process.env.SQL_PORT ?? '3306'),
    },
});