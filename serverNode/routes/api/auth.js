const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const config = require('config');
const jwt = require('jsonwebtoken');
const auth = require('../../middleware/auth')


//model
const User = require('../../models/User');


//@route get api/auth
//@desc 
//@access public
router.get('/', auth, async(req,res)=> {
    try {
        const user = await User.findById(req.user.id).select('-password');
        res.json(user);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('server error');
    }
});


//@route POST api/auth
//@desc authenticate new user
//@access Public
router.post('/', (req,res)=>{
    const {email, password} = req.body;
    
    //validation
    if(!email || !password){
        return res.status(400).json({res: "incorrect", msg: "incorrect syntax"});
    }

    //check existing
    User.findOne({email})
    .then(user => {
        if(!user) return res.status(400).json({res: "incorrect", msg: "user doesn't exist"});

        //validate psw
         bcrypt.compare(password, user.password)
         .then(isMatch => {
             if(!isMatch) return  res.status(400).json({res: "incorrect", msg: "invalid password"});

             jwt.sign(
                { id: user.id},
                config.get('jwtSecret'),
                {expiresIn: 3600*30},
                (err, token) => {
                    if (err) throw err;
                    res.json({
                        user,
                        res: "correct", 
                        msg: "user connected",
                        token: token,
                         user: user
                    })
                }
            )
         })


    })
});

//@route POST api/auth
//@desc authenticate new user
//@access Public
router.get('/user', auth, (req, res)=> {
    User.findById(req.user.id)
    .then(user => res.json(user));
})


// //@route GET api/users
// //@desc GET User by id
// //@access Public
// router.get('/:id', async(req,res)=>{
//     User.findById(req.params.id)
//         .then(user => res.json(user))
//         .catch(err => res.status(404).json({error: 'id doesn\'t exists'}))
// });

// //@route GET api/users
// //@desc GET user by category
// //@access Public
// // router.get('', async(req,res)=>{
// //     var query = {idCategory: "sport"}
// //     User.find(query)
// //         .then(user => res.json(user))
// //         .catch(err => res.status(404).json({error: 'id doesn\'t exists'}))
// // });


// //@route DELETE api/users
// //@desc DELETE users by id
// //@access Public
// router.delete('/:id', async(req,res) =>{
//     User.findById(req.params.id)    
//     .then(user => user.remove().then(() => res.json({success: true})))
//     .catch(err => res.status(404).json({success: false}));
// } );



// //@route POST api/users
// //@desc POST User
// //@access Public
// router.post('/', async(req,res) =>{
//     const newUser = new User({
//         email: req.body.email,
//         pseudo: req.body.pseudo,
//         password: req.body.password
//     });
//     newUser.save().then(user => res.json(user))
//     .catch(err => res.status(404).json({success: false}));
//     } ); 

    module.exports = router;



