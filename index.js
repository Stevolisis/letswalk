const express=require('express');
const app=express();
const bodyParser=require('body-parser')
const cors=require("cors");
var admin = require("firebase-admin");
var serviceAccount = require("./firebase.json");
require('dotenv').config();

app.listen(3000,(res,err)=>{
    if(err){
        console.log(err)
    }else{
        console.log("listening at port 80");
    }
})
//
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
app.use(cors());
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

//
const authorizedUsers=[
    {regNo:'18/000155U/2',password:'12345', name:"Salamatu Idris"},
    {regNo:'18/000255U/2',password:'123456', name: "Kayode Usman"},
    {regNo:'18/000355eU/2',password:'123457', name: "Cladius Wunti"},
];



app.get('/',(req,res)=>{
    res.sendFile(__dirname+'/index.html');
})
//

app.post('/login',async(req,res)=>{
    const {regNo,password}=req.body;
    console.log(req.body);


    try{
        if(regNo!==''&&password!==''){
            const isValid=authorizedUsers.some(user=>user.regNo===regNo&&user.password===password);
            

            if(isValid){
                const token=await admin.auth().createCustomToken('CustomToken'+Math.random(),{user:regNo});

                const user = authorizedUsers.find(({regNo : xRegNo}) => {
                    return xRegNo == regNo;
                })

                res.status(200).json({status:'success', token:token, username: user.name })
            }else{
                res.status(401).json({status:'Invalid credentials'});
            }
        }else{
            res.status(404).json({status:'error field not Found'})
        }
    }catch(err){
        res.status(404).json({status:'error occured',message:err.message})
    }
})