import { eq, or } from "drizzle-orm";
import drizzleDatabase from "../drizzle_mysql/database";
import { DB_User, DB_User_Schema, DBN_User, users } from "../drizzle_mysql/schemas/user_schema";

const createUser = async (data: DBN_User): Promise<DB_User> => {
  const response = await drizzleDatabase.insert(users).values({
    uuid: data.uuid,
    email: data.email,
    name: data.name,
    photo: data.photo,
    birthdate: data.birthdate
  }).$returningId();
  return DB_User_Schema.parse({ ...data, uid: response[0]!.uid });
};

const getUserData = async (uniqueData: string): Promise<DB_User | undefined> => {
  let uid = parseInt(uniqueData);
  const response = await drizzleDatabase.select().from(users).where(or(
    eq(users.uuid, uniqueData),
    eq(users.email, uniqueData),
    uid ? eq(users.uid, uid) : undefined,
  ));

  if (response.length === 0 || !response.at(0)) return undefined;
  const element = response.at(0);
  console.log(element);
  return element;
};

/* const getUserProfilePic = async (
  uniqueData: string
): Promise<Buffer | undefined> => {
  console.log("#Calling Image Function.");
  const [rows, _] = await connectionConfig.query<RowDataPacket[]>(
    findUserImageQuery,
    Array.from(
      {
        length: 3,
      },
      () => uniqueData
    )
  );
  console.log(rows);

  if (rows.length === 0 || !rows.at(0)) return undefined;
  const element = rows.at(0);
  return element!.photo;
}; */

export { createUser, getUserData, /* getUserProfilePic */ };
