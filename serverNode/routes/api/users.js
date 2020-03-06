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
router.post('/', (req,res)=>{
    const {pseudo, email, password} = req.body;
    //validation
    if(!pseudo || !email || !password){
        return res.status(400).json({res: "incorrect", msg: "incorrect syntax"});
    }

    //check existing
    User.findOne({email})
    .then(user => {
        if(user) return res.status(400).json({res: "incorrect", msg: "user already exist"});

        const newUser = new User({
            pseudo,
            email,
            password
        });

        //create salt & hash 
        bcrypt.genSalt(10, (err, salt) => {
            bcrypt.hash(newUser.password, salt, (err, hash) => {
                if(err) throw err;
                newUser.password = hash;
                newUser.save()
                .then(user => {
                    
                    jwt.sign(
                        { id: user.id},
                        config.get('jwtSecret'),
                        {expiresIn: 3600*30},
                        (err, token) => {
                            if (err) throw err;
                            res.json({
                                token: token,
                                res: "correct",
                                msg : "user has been created"
                                
                        })
                        }
                    )
                    
            });
            })
        })

    })
});

//@route GET api/users
//@desc GET User by id
//@access Public
router.get('/:id', auth, async(req,res)=>{
    User.findById(req.id)
        .then(user => res.json(user))
        .catch(err => res.status(404).json({error: 'user does not exists'}))
});

//@route GET api/user
//@desc GET all user
//@access Public
router.get('/', async(req,res)=>{
    User.find()
        .sort({date: 1})
        .then(remarks => res.json(remarks))
});




//@route DELETE api/users
//@desc DELETE users by id
//@access Public
router.delete('/:id', async(req,res) =>{
    User.findById(req.params.id)    
    .then(user => user.remove().then(() => res.json({success: true})))
    .catch(err => res.status(404).json({success: false}));
} );

    module.exports = router;



