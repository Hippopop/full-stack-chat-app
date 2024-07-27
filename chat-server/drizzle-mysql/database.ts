import * as dotenv from "dotenv";
import mysql from "mysql2/promise";
import { drizzle } from "drizzle-orm/mysql2";


dotenv.config();
const connection = mysql.createPool({
    connectionLimit: 10,
    port: parseInt(process.env.SQL_PORT ?? '3306'),
    user: process.env.SQL_USER,
    host: process.env.SQL_HOST,
    database: process.env.DATABASE_NAME,
    password: process.env.SQL_PASSWORD,
});

export const drizzleDatabase = drizzle(connection);
