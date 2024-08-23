import fs from "fs";
import multer from "multer";

import { Request } from "express";
import { profilePathString } from "../../constants/directories";
import { ResponseError } from "../../types/response/errors/error-z";

function imageDestinationDefiner(req: Request): string | undefined {
  switch (req.path) {
    case "/register":
      return profilePathString;
  }
}


//NOTE: So far unused, bcz of the [Render] disk issue! 
const storage = multer.diskStorage({
  destination: (req, file, callback) => {
    let path = "";
    let error: Error | null = null;
    if (imageDestinationDefiner(req)) {
      path = imageDestinationDefiner(req)!;
      if (!fs.existsSync(path)) {
        fs.mkdirSync(path, { recursive: true });
      }
    } else {
      error = new ResponseError(500, "Couldn't store image to server!");
    }
    callback(error, path);
  },
  filename: (req, file, callback) => {
    let error: Error | null = null;
    const name = file.mimetype.split("/");
    const uniqueSuffix = Date.now() + "_" + Math.round(Math.random() * 1e9);
    callback(error, `${name[0]}_${uniqueSuffix}.${name[1]}`);
  },
});

const multerConfig = multer({
  // NOTE: Using memory storage. Bcz, [Render] doesn't provide a disk storage, for free instances!
  // storage: multer.memoryStorage(),

  storage: storage,
  preservePath: true,
  fileFilter: (req, file, callback) => {
    let error: Error | null = null;
    // Decision.
    if (!file.mimetype.startsWith("image")) {
      error = new ResponseError(500, "Invalid file/mime type! (@multerConfig)");
    }
    // Final Output.
    if (error) {
      callback(error);
    } else {
      callback(error, true);
    }
  },
});

export default multerConfig;
