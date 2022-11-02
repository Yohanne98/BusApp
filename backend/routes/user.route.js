const express = require('express')
const User = require('../models/user.model')
const router = express.Router()

// router.get('/',(req,res)=>{
//     console.log('Hello world')
// })


router.post('/signup',(req,res)=>{
    User.findOne({email:req.body.email},(err,user)=>{
        if(err){
            console.log(err)
            res.json(err)
        }else{
            if(user==null){
                const user = User({
                    email:req.body.email,
                    password:req.body.password
                })
                user.save()
                .then((err)=>{
                    if(err){
                        console.log(err)
                        res.json(err)
                    }else{
                        console.log(user)
                        res.json(user)
                    }
                    
                })

            res.json({
                message:'email is not avilable'
            })   
            }
        }
    })
    
})

router.post('/signin',(req,res)=>{
    User.findOne({email:req.body.email,password:req.body.password},(err,user)=>{
        if(err){
            console.log(err)
            res.json(err)
        }else{
            console.log(user)
            res.json(user)   
        }
    })
})

//router.route('/:id/reviews').post(protect, createProductReview)

router.post('/:id/reviews',(req,res)=>{
    //const user1 = User.findById("63612c98b39d66b9d0c9b864");

    User.findOne({_id:"63612c98b39d66b9d0c9b864"},(err,user)=>{
        if(err){
            console.log(err)
            res.json(err)
        }else{
            if(user==null){
                const journey = {
                    date: new Date().toJSON().slice(0, 10),
                    from: "Kottawa",
                    to: "rukamlgama",
                    distance: 20,
                    fare: 150,
                    user: "",
                }

                const user = User({
                    journeys:journey,
                })
                console.log(user)
                user.journeys.push(journey)
                user.save()
                .then((err)=>{
                    if(err){
                        console.log(err)
                        res.json(err)
                    }else{
                        console.log(user)
                        res.json(user)
                    }
                    
                })

            res.json({
                message:'email is not avilable'
            })   
            }
            

            console.log(user)
            res.json(user)   

            

        //         "date": "2022-11-5",
        // "from": "Kottawa",
        // "to":"rukamlgama",
        // "distance": 20,
        // "fare":150,
        // "user": ""
              }

              //user.journeys.save(journey)

            //   const user = User({
            //     journeys:journey,
            })
            //user.save()
        }

        
    )

    // res.json(user1._id)
    // console.log(user1.name)
  
    // if (user1) {
    // //   const alreadyReviewed = product.reviews.find(
    // //     (r) => r.user.toString() === req.user._id.toString()
    // //   )
  
    // //   if (alreadyReviewed) {
    // //     res.status(400)
    // //     throw new Error('Product already reviewed')
    // //   }
  
    //   const journey = {
    //     date: new Date().toJSON().slice(0, 10),
    //     from: req.body.from,
    //     to: req.body.to,
    //     distance: req.body.distance,
    //     fare: req.body.fare,
    //     user: req.body._id,
    //   }

    //   console.log(journey)
  
    // //   user1.journeys.push(journey)
  
    // //   product.numReviews = product.reviews.length
  
    // //   product.rating =
    // //     product.reviews.reduce((acc, item) => item.rating + acc, 0) /
    // //     product.reviews.length
  
    // // user1.save()
    // //   res.status(201).json({ message: 'Review added' })
    // } else {
    // //   res.status(404)
    // //   throw new Error('User not fould')
    // }


// const createJourney = asyncHandler(async (req, res) => {
//     //const { rating, comment } = req.body
  
//     const user = await User.findById(req.params.id)
  
//     if (user) {
//     //   const alreadyReviewed = product.reviews.find(
//     //     (r) => r.user.toString() === req.user._id.toString()
//     //   )
  
//     //   if (alreadyReviewed) {
//     //     res.status(400)
//     //     throw new Error('Product already reviewed')
//     //   }
  
//       const journey = {
//         date: new Date().toJSON().slice(0, 10),
//         from: req.body.from,
//         to: req.body.to,
//         distance: req.body.distance,
//         fare: req.body.fare,
//         user: req.body._id,
//       }
  
//       user.journeys.push(journey)
  
//     //   product.numReviews = product.reviews.length
  
//     //   product.rating =
//     //     product.reviews.reduce((acc, item) => item.rating + acc, 0) /
//     //     product.reviews.length
  
//       await product.save()
//       res.status(201).json({ message: 'Review added' })
//     } else {
//       res.status(404)
//       throw new Error('User not fould')
//     }
//   })


module.exports = router