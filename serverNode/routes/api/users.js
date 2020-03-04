const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const config = require('config');
const jwt = require('jsonwebtoken');

//model
const User = require('../../models/User');


//@route POST api/users
//@desc register new user
//@access Public
router.post('/', (req,res)=>{
    const {pseudo, email, password} = req.body;
    //validation
    if(!pseudo || !email || !password){
        return res.status(400).json({msg: "incorrect syntax"});
    }

    //check existing
    User.findOne({email})
    .then(user => {
        if(user) return res.status(400).json({msg: "user already exist"});

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
                                user: {
                                id: user.id,
                                email: user.email
                        }})
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
router.get('/:id', async(req,res)=>{
    User.findById(req.params.id)
        .then(user => res.json(user))
        .catch(err => res.status(404).json({error: 'user does not exists'}))
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



