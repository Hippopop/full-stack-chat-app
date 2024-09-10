import { sql } from "drizzle-orm";
import { int } from "drizzle-orm/mysql-core";

export const getCurrentTimestampSeconds = (): number => Math.round(Date.now() / 1000);
export const convertDateToSecondsTimestamp = (date: Date | number): number => {
    if (date instanceof Date) return Math.round(date.getTime() / 1000);
    return Math.round(date / 1000);
};

export const drizzleTimeFields = {
    createdAt: int('created_at').default(sql`(unix_timestamp())`),
    updatedAt: int('updated_at').$onUpdate(() => getCurrentTimestampSeconds()),
};
