const express=require('express');
const app=express();
const bodyParser=require('body-parser')
const cors=require("cors");

app.listen(80,(res,err)=>{
    if(err){
        console.log(err)
    }else{
        console.log("listening at port 80");
    }
})

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
// app.use(express.json({limit:'1mb'}));
// app.use("/static",express.static('public'));
app.use(cors());

const authorizedUsers=[
    {regNo:'18/000155U/2',password:'12345'},
    {regNo:'18/000255U/2',password:'123456'},
    {regNo:'18/000355eU/2',password:'123457'},
];



app.get('/',(req,res)=>{
    res.sendFile(__dirname+'/index.html');
})


app.post('/login',(req,res)=>{
    const {regNo,password}=req.body;
    console.log(req.body)

    try{
        if(regNo!==''&&password!==''){
            const isValid=authorizedUsers.some(user=>user.regNo===regNo&&user.password===password);
            if(isValid){
                res.status(200).json({status:'success'})
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