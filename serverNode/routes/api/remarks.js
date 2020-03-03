const express = require('express');
const router = express.Router();

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
        .then(remark => res.json(remark))
        .catch(err => res.status(404).json({error: 'id doesn\'t exists'}))
});

//@route GET api/remarks
//@desc GET remark by category
//@access Public
// router.get('', async(req,res)=>{
//     var query = {idCategory: "sport"}
//     Remark.find(query)
//         .then(remark => res.json(remark))
//         .catch(err => res.status(404).json({error: 'id doesn\'t exists'}))
// });


//@route DELETE api/remarks
//@desc DELETE remarks by id
//@access Public
router.delete('/:id', async(req,res) =>{
    Remark.findById(req.params.id)    
    .then(item => item.remove().then(() => res.json({success: true})))
    .catch(err => res.status(404).json({success: false}));
} );



//@route POST api/remarks
//@desc POST remark
//@access Public
router.post('/', async(req,res) =>{
    const newRemark = new Remark({
        content: req.body.content,
        idCategory: req.body.idCategory,
    });
    newRemark.save().then(remark => res.json(remark));
    } ); 

    module.exports = router;



