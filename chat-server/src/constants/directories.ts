import path from "path";

export const root = path.resolve(process.cwd());
export const publicPathString = 'public/';
export const publicPath = path.resolve(`./${publicPathString}`);

export const uploadPathString = 'upload';
export const uploadPath = path.resolve(`./${uploadPathString}`);

export const profilePathString = `${uploadPathString}/profile/`;
export const profilePath = path.resolve(`./${profilePathString}`);