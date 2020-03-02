
const express = require('express');
const router = express.Router();

//item model
const Item = require('../../models/Item');

//@route GET api/items
//@desc Get all items
//@access Public
router.get('/', async(req,res) =>{
    Item.find()
        .sort({ date: -1})
        .then(items => res.json(items))
} );

router.post('/', async(req,res) =>{
    const newItem = new Item({
        name: req.body.name
    });
    newItem.save().then(item => res.json(item));
    } ); 

router.delete('/:id', async(req,res) =>{
    Item.findById(req.params.id)    
    .then(item => item.remove().then(() => res.json({success: true})))
    .catch(err => res.status(404).json({success: false}));
} ); 

module.exports = router;