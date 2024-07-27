import * as dotenv from "dotenv";
import { defineConfig } from "drizzle-kit";


dotenv.config();
export default defineConfig({
    dialect: "mysql",
    out: "./migrations",
    schema: "./schemas/*",
    migrations: {
        prefix: "timestamp",
    },
    dbCredentials: {
        user: process.env.SQL_USER ?? "root",
        host: process.env.SQL_HOST ?? "localhost",
        database: process.env.DATABASE_NAME ?? "full_stack_chat",
        port: parseInt(process.env.SQL_PORT ?? '3306'),
    },
});