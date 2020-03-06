const express = require('express');
const router = express.Router();
const auth = require('../../middleware/auth');


//model
const Remark = require('../../models/Remark');
const User = require('../../models/User');
const CategoryRemark = require('../../models/CategoryRemark');


//--------remarks----------

//@route GET api/remarks
//@desc GET all remarks
//@access Public
router.get('/', async(req,res)=>{
    Remark.find()
        .sort(function(a,b){a.answers.length-b.answers.length})
        .then(remarks => res.json(remarks))
});


//@route GET api/remarks
//@desc GET remark by id
//@access Public
router.get('/:id', async(req,res)=>{
    Remark.findById(req.params.id)
        .then(remark => res.json(remark))
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

//route 

//@route POST api/remarks
//@desc POST remark
//@access Private
router.post('/',auth, async(req,res) =>{
    const newRemark = new Remark({
        content: req.body.content,
        idCategory: req.body.idCategory,
        user: req.user.pseudo
    });
    newRemark.save().then(remark => res.json(remark));
    } ); 


//-------------answers--------------


//@route GET api/remarks
//@desc GET answers for remark
//@access Public
router.get('/:id/answers', async(req,res)=>{
    var query = req.params.id;
    Remark.findById(query)
        .then(remark => res.json(remark.answers))
        .catch(err => res.status(404).json({error: 'id doesn\'t exists'}))
});

//@route GET api/remarks
//@desc GET get answers for remark by category
//@access Public
router.get('/:id/answers/category', async(req,res)=>{
    var remark = await Remark.findById(req.params.id);
    var query = req.params.category;
    const answers = await remark.answers.find(answer => answer.idCategory === req.params.category)
    if(answers){ res.json(answers)} 
    else res.status(404).json({error: 'id doesn\'t exists'})
});




//@route POST api/remarks answer
//@desc POST answers
//@access Private
router.post('/:id/answers', async(req,res) =>{

    const newAnswer = new Remark({
        user: req.body.pseudo,
        content: req.body.content,
        idCategory: req.body.idCategory

    });
    const remark = await Remark.findById(req.params.id);
    remark.answers.unshift(newAnswer);

    remark.save().then(remark => res.json(remark));
    } );


//@route DELETE api/remarks/answer
//@desc DELETE answer by id
//@access private
router.delete('/:id/answers/:answerid',auth, async(req,res) =>{
    try{
    const remark = await Remark.findById(req.params.id);

    const answer = await remark.answers.find(answer => answer.id === req.params.answerid);
    if(!answer) res.status(404).json({msg: 'answer does not exit'});

    const removeIndex = remark.answers.map(answer => answer.id).indexOf(req.params.answerid);
    remark.answers.splice(removeIndex, 1);
    await remark.save();

    res.json(remark.answers);}
    catch(err){
        res.status(500).send('server error')
    }


} );

//----------likes----------

//@route POST api/remarks
//@desc POST like
//@access Private
router.post('/:id/likes',auth, async(req,res) =>{

    const newLike = new Remark({
        user: req.body.pseudo

    });
    const remark = await Remark.findById(req.params.id);
    const like = await remark.likes.find(like => like.user === newLike.user);
    if(!like){
        remark.likes.unshift(newLike);
        remark.save().then(remark => res.json(remark));
    }
    else res.status(400).json({msg: "remarks already liked"})
    } );

//@route DELETE api/remarks/answer
//@desc DELETE like by id
//@access private
router.delete('/:id/likes/:likeid',auth, async(req,res) =>{
    try{
    const remark = await Remark.findById(req.params.id);

    const like = await remark.likes.find(like => like.id === req.params.likeid);
    if(!like) res.status(404).json({msg: 'like does not exit'});

    const removeIndex = remark.likes.map(like => like.id).indexOf(req.params.likeid);
    remark.likes.splice(removeIndex, 1);
    await remark.save();

    res.json(remark.likes);}
    catch(err){
        res.status(500).send('server error')
    }
} );


    module.exports = router;



