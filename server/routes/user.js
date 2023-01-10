const express = require("express");
const userRouter = express.Router();

const auth = require("../middlewares/auth");
const User = require("../models/user");
const { Product } = require("../models/product");

// get my orders
userRouter.get("/api/orders/me", auth, async (req, res) => {
  try {
    const orders = await Product.find({ userId: req.user });
    console.log(req.user);
    res.json(orders);
  } catch (error) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ product: product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
          break;
        }
      }

      if (isProductFound) {
        let productInCart = user.cart.find((productItem) =>
          productItem.product._id.equals(product._id)
        );
        productInCart.quantity += 1;
      } else {
        user.cart.push({ product: product, quantity: 1 });
      }
    }
    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    let product = await Product.findById(id);
    let user = await User.findById(req.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
      }
    }
    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = userRouter;
