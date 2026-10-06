import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { Server } from 'socket.io';

const app=express();
const httpServer=createServer(app);
const io=new Server(httpServer,{cors:{origin:'*'}});
app.use(cors()); app.use(express.json({limit:'10mb'}));
const messages=new Map();
app.get('/health',(_,res)=>res.json({ok:true,service:'lucky-chat',time:new Date().toISOString()}));
app.get('/api/messages/:roomId',(req,res)=>res.json(messages.get(req.params.roomId)||[]));
io.on('connection',socket=>{
  socket.on('room:join',roomId=>socket.join(roomId));
  socket.on('message:send',payload=>{
    const msg={...payload,id:crypto.randomUUID(),createdAt:new Date().toISOString()};
    const arr=messages.get(payload.roomId)||[]; arr.push(msg); messages.set(payload.roomId,arr.slice(-500));
    io.to(payload.roomId).emit('message:new',msg);
  });
});
const port=process.env.PORT||3000; httpServer.listen(port,()=>console.log(`Lucky Chat server on :${port}`));
