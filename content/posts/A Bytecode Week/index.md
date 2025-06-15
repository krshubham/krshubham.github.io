---
title: "A Bytecode Week"
date: 2019-05-17T13:27:03+05:30
draft: false
tags: [java, bytecode]
---

```java
final InsnList list = new InsnList();
list.add(new LdcInsnNode(new Integer(100)); // Load Constant instruction
list.add(new MethodInsnNode(Opcodes.INVOKESTATIC, "java/lang/Thread", "sleep", "(J)V", false)); // Invoke the method
// Look something like a stack machine? That's right, its the JVM bytecode.
```

How many of us, do really study subjects like microprocessor, thinking that we are gonna use this knowledge further in our day to day job? I too was with that mindset in the college, but as you can see and will get to know further, these things have re-appeared 🤯🤯

So let's come to the problem that we are solving.Suppose you have a java application, I am asking you to add a delay to all the method calls within this application, how would you do that?

One idea is too add a Thread.sleep call to all the methods manually and then recompile the entire application and wow, there, you have a delay in all the method calls in your application, great job. Now what if I want to add a delay to random methods and not all at the same time.

Think for some time, we can still do this manually right? Generate random float between 0 to 1 and if its greater than 0.5, or a defined threshold, then we can add a Thread.sleep call to this method, wow again we did it. Good job! 😏

How scalable is that solution? Imagine we have thousands of methods and we use the above way to add Thread.sleep calls to the methods, well its fine if you have sprints that are year long but here at AppD we are trying to be as Agile as possible and thus such a way of solving this problem might be a problem in itself 😐.

So how do we solve this? Here comes to rescue, an awesome solution which is a part of the JVM itself, the **javaagent**.

For example

```bash
# Running your java application with a javaagent for instrumentation
java -javaagent:/path/to/some-agent.jar -jar your-application.jar
```

Now this ``some-agent.jar`` is actually the core part for solving this problem. This java agent allows you to modify or transform the classes as they are loaded into the JVM. It can even create new classes, all of this at runtime, without modifying a single line of code in your application. Think of how useful the javaagent can be! 🤯All of this is done by modifying bytecodes directly. Just to let you know, JVM is a stack machine basically and while modifying at the bytecode level you can get this feel very easily. Discussion of how we modified the bytecode to add new method calls, will be dealt in a later post. For now, just see how libraries like [asm](https://asm.ow2.io/) allow you do this with a lot of flexibility.

Also, in this week we had our team outing and we decided to go to [Torq03](https://torq03.com/), for some fun and chill. We had fun with Go Karting and bowling and finally I have to say: this team is ❤️.



