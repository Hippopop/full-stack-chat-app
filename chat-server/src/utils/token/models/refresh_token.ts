import z from "zod";

export const RefreshTokenSchema = z.object({
    token: z.string(),
    sha256: z.string(),
    uuid: z.string().uuid(),
    email: z.string().email(),
    expire: z.number(),
    timestamp: z.number(),
});

export type RefreshTokenModel = z.infer<typeof RefreshTokenSchema>;