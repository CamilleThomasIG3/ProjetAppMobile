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
        .sort({date: -1})
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
router.delete('/:id', async(req,res) =>{
    Remark.findById(req.params.id)    
    .then(item => item.remove().then(() => res.json({res:"correct", msg:"remark has been deleted"})))
    .catch(err => res.status(404).json({res:"incorrect", msg:"remark not found"}));
} );

//route 

//@route POST api/remarks
//@desc POST remark
//@access Private
router.post('/', async(req,res) =>{
    const newRemark = new Remark({
        title: req.body.title,
        content: req.body.content,
        idCategory: req.body.idCategory,
        user: req.body.pseudo
    });
    newRemark.save().then(remark => res.json({remark: newRemark, res:"correct", msg:"remark posted"}));
    } ); 


//-------------remark/answers--------------


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

    const newAnswer = {
        user: req.body.pseudo,
        content: req.body.content,
        categoryResponse: req.body.categoryResponse

    };
    const remark = await Remark.findById(req.params.id);
    remark.answers.unshift(newAnswer);

    remark.save().then(remark => res.json({res:"correct", msg:"answer posted"}));
    } );


//@route DELETE api/remarks/answer
//@desc DELETE answer by id
//@access private
router.delete('/:id/answers/:answerid', async(req,res) =>{
    try{
    const remark = await Remark.findById(req.params.id);

    const answer = await remark.answers.find(answer => answer.id === req.params.answerid);
    if(!answer) res.status(404).json({res:"incorrect", msg: 'answer does not exit'});

    const removeIndex = remark.answers.map(answer => answer.id).indexOf(req.params.answerid);
    remark.answers.splice(removeIndex, 1);
    await remark.save();

    res.json({res:"correct", msg:"answer deleted"});}
    catch(err){
        res.status(500).send('server error')
    }


} );

//----------remarks/answers/like----------





//@route POST api/remarks/answers/likes
//@desc POST answers
//@access Private
router.post('/:id/answers/:answerid', async(req,res) =>{

    const newLike = {
        user: req.body.pseudo
    };
    if (!newLike.user){
        res.json({res:"incorrect", msg: "incorrect syntax"})
    }
    else{
        const remark = await Remark.findById(req.params.id);
        const answer = await remark.answers.find(answer => answer.id === req.params.answerid);
        const like = await answer.likes.find(like => like.user === newLike.user)
        if(!like){
            answer.likes.unshift(newLike);
            remark.save().then(remark => res.json({res:"correct", msg:"answer liked"}));
        }
        else res.status(400).json({res:"incorrect", msg: "answer already liked"})
    }} );


//@route DELETE api/remarks/answer/likes
//@desc DELETE answer by id
//@access private
router.delete('/:id/answers/:answerid/likes/:likeid', async(req,res) =>{
    try{
    const remark = await Remark.findById(req.params.id);
    const answer = await remark.answers.find(answer => answer.id === req.params.answerid);
    const like = await answer.likes.find(like => like.id === req.params.likeid)
    if(!like) res.status(404).json({res:"incorrect", msg: 'like does not exit'});

    const removeIndex = answer.likes.map(like => like.id).indexOf(req.params.likeid);
    answer.likes.splice(removeIndex, 1);
    await remark.save();

    res.json({res:"correct", msg:"remark disliked"});}
    catch(err){
        res.status(500).send('server error')
    }
} );

//A VERIFIER !!!! (je l'ai changé hier soir sur le serveur est ce une bonne idée ? en plus marche pas supprime premier like pas celui quon veut)
// router.delete('/:id/answers/:answerid/likes/:user', async(req,res) =>{
//     try{
//     const remark = await Remark.findById(req.params.id);
//     const answer = await remark.answers.find(answer => answer.id === req.params.answerid);
//     const like = await answer.likes.find(like => like.user === req.params.user)
//     if(!like) res.status(404).json({res:"incorrect", msg: 'like does not exit'});

//     const removeIndex = answer.likes.map(like => like.id).indexOf(req.params.likeid);
//     answer.likes.splice(removeIndex, 1);
//     await remark.save();

//     res.json({res:"correct", msg:"remark disliked"});}
//     catch(err){
//         res.status(500).send('server error')
//     }
// } );


//----------remarks/answers/signal----------





//@route POST api/remarks/answers/signals
//@desc POST answers
//@access Private
router.post('/:id/answers/:answerid/signals', async(req,res) =>{

    const newSignal = {
        user: req.body.pseudo
    };
    if (!newSignal.user){
        res.json({res:"incorrect", msg: "incorrect syntax"})
    }
    else{
        const remark = await Remark.findById(req.params.id);
        const answer = await remark.answers.find(answer => answer.id === req.params.answerid);
        const signal = await answer.signals.find(signal => signal.user === newSignal.user)
        if(!signal){
            answer.signals.unshift(newSignal);
            remark.save().then(remark => res.json({res:"correct", msg:"answer signaled"}));
        }
        else res.status(400).json({res:"incorrect", msg: "answer already signaled"})
    }} );


//@route DELETE api/remarks/answer/signals
//@desc DELETE answer by id
//@access private
router.delete('/:id/answers/:answerid/signals/:signalid', async(req,res) =>{
    try{
    const remark = await Remark.findById(req.params.id);
    const answer = await remark.answers.find(answer => answer.id === req.params.answerid);
    const signal = await answer.signals.find(signal => signal.id === req.params.signalid)
    if(!signal) res.status(404).json({res:"incorrect", msg: 'signal does not exit'});

    const removeIndex = answer.signals.map(signal => signal.id).indexOf(req.params.signalid);
    answer.signals.splice(removeIndex, 1);
    await remark.save();

    res.json({res:"correct", msg:"remark unsignaled"});}
    catch(err){
        res.status(500).send('server error')
    }
} );




//----------remarks/likes----------

//@route POST api/remarks
//@desc POST like
//@access Private
router.post('/:id/likes',async(req,res) =>{

    const newLike = {
        user: req.body.pseudo

    };
    const remark = await Remark.findById(req.params.id);
    const like = await remark.likes.find(like => like.user === newLike.user);
    if(!like){
        remark.likes.unshift(newLike);
        remark.save().then(remark => res.json({res:"correct", msg:"remark liked"}));
    }
    else res.status(400).json({res:"incorrect", msg: "remark already liked"})
    } );

//@route DELETE api/remarks/answer
//@desc DELETE like by id
//@access private
router.delete('/:id/likes/:likeid', async(req,res) =>{
    try{
    const remark = await Remark.findById(req.params.id);

    const like = await remark.likes.find(like => like.id === req.params.likeid);
    if(!like) res.status(404).json({res:"incorrect", msg: 'like does not exit'});

    const removeIndex = remark.likes.map(like => like.id).indexOf(req.params.likeid);
    remark.likes.splice(removeIndex, 1);
    await remark.save();

    res.json({res:"correct", msg:"remark disliked"});}
    catch(err){
        res.status(500).send('server error')
    }
} );


    module.exports = router;



