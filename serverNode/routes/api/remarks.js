const express = require('express');
const router = express.Router();
const auth = require('../../middleware/auth');


//model
const Remark = require('../../models/Remark');
const User = require('../../models/User');
const CategoryRemark = require('../../models/CategoryRemark');


//@route GET api/remarks
//@desc GET all remarks
//@access Public
router.get('/', async(req,res)=>{
    Remark.find()
        .sort({date: 1})
        .then(remarks => res.json(remarks))
});

//@route GET api/remarks
//@desc GET remark by id
//@access Public
router.get('/:id', async(req,res)=>{
    Remark.findById(req.params.id)
        .then(remark => res.json(user))
        .catch(err => res.status(404).json({error: 'remark does not exists'}))
});



//@route GET api/remarks
//@desc GET remark by category
//@access Public
router.get('/categorie/:idCategory', async(req,res)=>{
    var query = req.params.idCategory;
    Remark.find( {"idCategory" : query})
        .then(remark => res.json(remark))
        .catch(err => res.status(404).json({error: 'id doesn\'t exists'}))
});

//@route GET api/remarks
//@desc GET answers for remark
//@access Public
router.get('/:id/answers', async(req,res)=>{
    var query = req.params.id;
    Remark.findById(query)
        .then(remark => res.json({answers: remark.answers}))
        .catch(err => res.status(404).json({error: 'id doesn\'t exists'}))
});



//@route GET api/remarks
//@desc GET remark by user
//@access Public
router.get('/user/:User', async(req,res)=>{
    var query = req.params.User;
    Remark.find( {"user" : query})
        .then(remark => res.json(remark))
        .catch(err => res.status(404).json({error: 'id doesn\'t exists'}))
});


//@route DELETE api/remarks
//@desc DELETE remarks by id
//@access private
router.delete('/:id',auth, async(req,res) =>{
    Remark.findById(req.params.id)    
    .then(item => item.remove().then(() => res.json({success: true})))
    .catch(err => res.status(404).json({success: false}));
} );

//@route POST api/remarks
//@desc POST remark
//@access Private
router.post('/',auth, async(req,res) =>{
    const newRemark = new Remark({
        content: req.body.content,
        idCategory: req.body.idCategory,
        answers: req.body.answers
    });
    console.log(newRemark)
    newRemark.save().then(remark => res.json(remark));
    } ); 

    module.exports = router;



