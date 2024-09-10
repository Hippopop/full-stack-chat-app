import z from "zod";
import { DB_ConnectionStatus_Schema } from "../../drizzle_mysql/schemas/connection_schema";
import { DB_Message_Schema } from "../../drizzle_mysql/schemas/message_schema";

export const HomieInfoSchema = z.object({
    homie: z.object({
        name: z.string(),
        uuid: z.string().uuid(),
        photo: z.string().nullable(),
        isActive: z.boolean().nullable(),
        lastActivity: z.number().nullable(),
    }),
    connection: z.object({
        key: z.number(),
        acceptedAt: z.number().nullable(),
        status: DB_ConnectionStatus_Schema.nullable(),
    }),
    message: DB_Message_Schema.nullable(),
});

export type HomieInfo = z.infer<typeof HomieInfoSchema>;