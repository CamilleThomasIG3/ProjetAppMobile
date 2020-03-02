const express = require('express');
const router = express.Router();

//model
const User = require('../../models/User');


//@route GET api/users
//@desc GET all users
//@access Public
router.get('/', async(req,res)=>{
    User.find()
        .sort({date: 1})
        .then(users => res.json(users))
});

//@route GET api/users
//@desc GET User by id
//@access Public
router.get('/:id', async(req,res)=>{
    User.findById(req.params.id)
        .then(user => res.json(user))
        .catch(err => res.status(404).json({error: 'id doesn\'t exists'}))
});

//@route GET api/users
//@desc GET user by category
//@access Public
// router.get('', async(req,res)=>{
//     var query = {idCategory: "sport"}
//     User.find(query)
//         .then(user => res.json(user))
//         .catch(err => res.status(404).json({error: 'id doesn\'t exists'}))
// });


//@route DELETE api/users
//@desc DELETE users by id
//@access Public
router.delete('/:id', async(req,res) =>{
    User.findById(req.params.id)    
    .then(item => item.remove().then(() => res.json({success: true})))
    .catch(err => res.status(404).json({success: false}));
} );



//@route POST api/users
//@desc POST User
//@access Public
router.post('/', async(req,res) =>{
    const newUser = new User({
        email: req.body.email,
        pseudo: req.body.pseudo,
        password: req.body.password
    });
    newUser.save().then(user => res.json(user));
    } ); 

    module.exports = router;



