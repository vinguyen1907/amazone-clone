// IMPORT FROM PACKAGE
const express = require("express");
const mongoose = require("mongoose");

// IMPORT FROM FILE
const authRouter = require("./routes/auth");
const userRouter = require("./routes/user");
const productRouter = require("./routes/product");
const adminRouter = require("./routes/admin");

// INITIALIZE
const PORT = 3000;
const app = express();
const DBUrl =
  "mongodb+srv://vinguyen:vinguyen@cluster0.zs1vfsu.mongodb.net/?retryWrites=true&w=majority";
mongoose.set("strictQuery", true);

// MIDDLEWARE
app.use(express.json());
app.use(authRouter);
app.use(userRouter);
app.use(productRouter);
app.use(adminRouter);

// CONNECT TO DB
mongoose
  .connect(DBUrl)
  .then(() => console.log("Connect successfully"))
  .catch((err) => console.log(err));

// CREATE API

app.listen(PORT, "0.0.0.0", () => {
  console.log("listening on port " + PORT);
});
