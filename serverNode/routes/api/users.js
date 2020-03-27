const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const config = require('config');
const jwt = require('jsonwebtoken');

//model
const User = require('../../models/User');

const auth = require('../../middleware/auth');

//@route POST api/users
//@desc register new user
//@access Public
router.post('/', (req, res) => {
    const { pseudo, email, password } = req.body;
    //validation
    if (!pseudo || !email || !password) {
        return res.status(400).json({ res: "incorrect", msg: "incorrect syntax" });
    }

    //check existing
    User.findOne({ pseudo })
        .then(user => {
            if (user) return res.status(400).json({ res: "incorrect", msg: "pseudo already exist" });
        });
    User.findOne({ email })
        .then(user => {
            if (user) return res.status(400).json({ res: "incorrect", msg: "email already exist" });

            const newUser = new User({
                pseudo,
                email,
                password
            });

            //create salt & hash 
            bcrypt.genSalt(10, (err, salt) => {
                bcrypt.hash(newUser.password, salt, (err, hash) => {
                    if (err) throw err;
                    newUser.password = hash;
                    newUser.save()
                        .then(user => {

                            jwt.sign(
                                { id: user.id },
                                config.get('jwtSecret'),
                                { expiresIn: 3600 * 30 },
                                (err, token) => {
                                    if (err) throw err;
                                    res.json({
                                        user: user,
                                        token: token,
                                        res: "correct",
                                        msg: "user has been created"

                                    })
                                }
                            )

                        });
                })
            })

        })
});


//@route put api/users
//@desc update user's pseudo
//@access Public
router.put('/:id', async (req, res) => {
    const newPseudo = req.body.newPseudo;
    const password = req.body.password
    const id = req.params.id
    if (!newPseudo || !password) return res.status(400).json({ res: "incorrect", msg: "error syntax" })
    User.findById(id)
    .then(user => {
        if(!user) return res.status(400).json({res: "incorrect", msg: "user doesn't exist"});

        //validate psw
         bcrypt.compare(password, user.password)
         .then(isMatch => {
             if(!isMatch) return  res.status(400).json({res: "incorrect", msg: "invalid password"});
             else{
                User.findOneAndUpdate(
                    {_id: id},
                    {
                        $set:{
                            pseudo: newPseudo
                        }
                    }
                ).then(user => res.json({res: "correct", msg:"pseudo updated"}))
                .catch(err => res.status(404).json({ res: "incorrect", msg: 'pseudo already used' }))
             }
         })
})})

//@route put api/users
//@desc update user's pseudo
//@access Public
router.put('/:id', async (req, res) => {
    const newAdmin = req.body.newAdmin;
    const id = req.params.id
    if (!newAdmin) return res.status(400).json({ res: "incorrect", msg: "error syntax" })
    User.findById(id)
    .then(user => {
        if(!user) return res.status(400).json({res: "incorrect", msg: "user doesn't exist"});

        //validate psw
        //  bcrypt.compare(password, user.password)
        //  .then(isMatch => {
             if(!isMatch) return  res.status(400).json({res: "incorrect", msg: "invalid password"});
            //  else{
                User.findOneAndUpdate(
                    {_id: id},
                    {
                        $set:{
                            admin: newAdmin
                        }
                    }
                ).then(user => res.json({res: "correct", msg:"admin updated"}))
                .catch(err => res.status(404).json({ res: "incorrect", msg: 'impossible to change admin status' }))
            //  }
        //  })
})})

//@route GET api/users
//@desc GET User by id
//@access Public
router.get('/:id', async (req, res) => {
    User.findById(req.params.id)
        .then(user => res.json(user))
        .catch(err => res.status(404).json({ error: 'user does not exists' }))
});

//@route GET api/users
//@desc GET User by id
//@access Public
router.get('/email/:email', async (req, res) => {
    const email = req.params.email;
    User.findOne({ email })
        .then(user => res.json(user))
        .catch(err => res.status(404).json({ res: "incorrect,", msg: "user doesn't exist" }))
});


//@route GET api/user
//@desc GET all user
//@access Public
router.get('/', async (req, res) => {
    User.find()
        .sort({ date: 1 })
        .then(users => res.json(users))
});




//@route DELETE api/users
//@desc DELETE users by id
//@access Public
router.delete('/:id', async (req, res) => {
    User.findById(req.params.id)
        .then(user => user.remove().then(() => res.json({ res: "correct", msg: "user has been deleted" })))
        .catch(err => res.status(404).json({ res: "incorrect", msg: "user not found" }));
});


//@route DELETE api/users
//@desc DELETE users by email
//@access Public
// router.delete('/:email', async(req,res) =>{
//     const email = req.params.email;
//     User.findOne({email})
//     .then(user => user.remove().then(() => res.json({res:"correct", msg:"user has been deleted"})))
//     .catch(err => res.status(404).json({res:"incorrect", msg:"user not found"}));
// } );

module.exports = router;

