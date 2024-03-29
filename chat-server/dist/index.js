"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const port = process.env.PORT ?? 8080;
const app = (0, express_1.default)();
app.listen(port, () => console.log(`Listening on port ${port} // http://localhost:${port}/`));
//# sourceMappingURL=index.js.map