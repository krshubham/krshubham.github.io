+++
title = "Togetherness of a Family: A tree problem"
date =  2021-01-10
+++

### About the Problem
The problem is a typical tree problem: 
```text
In the world of magic land, there is a park in which a group of people are playing a game. Every person in the group is a child of one another person in the group except one person who is the parent of all the people in the group. Here, each person is represented by a number that if there are ‘n’ persons in the group then they are represented by numbers 1 to 7. The direct and indirect child relationship is defined as follows:
(i) A person ‘b’ is said to be direct child of ‘a’ if ‘a’ is parent of ‘b’.
(ii) Person is ‘c’ is said to be indirect child of ‘a’ when ‘c’ is child of ‘b’ and ‘b’ is child of ‘a’.
(iii) A indirect child ‘i’ of a person ‘p’ is also an indirect child of parent of ‘p’.
In the game, everyone is given a token which has a number written on it and to test the togetherness of the family, the family is given some queries.
In one query, a number representing a person is given and it is asked to find the number of direct and indirect children of the person who have prime number in the token given to them.
For more clarifications see the example below.
There are seven person in the group and the tokens assigned to each of them are:
Person
Token Number
1
1
2
2
3
3
4
4
5
5
6
6
7
7
We are given 2 queries:
Query1: The person numbered as 1 is given and we need to findout the number of children(both direct and indirect under 1) which have a token with prime number value:
Answer: 4.
Explanation:
For the person numbered as 1, its direct children are persons numbered as 2 and 3 and they have tokens 2 and 3 respectively which are prime numbers.
The person numbered as 5 and 7 are also children (indirect) of the person number 1 hence they also added up to the count and hence there are a total of 4 people who are children of person number 1 and have a prime number token.
Query2: The person numbered as 6 is given
Answer: 0.
Explanation:
The person with number 6 has no children and hence there are 0 children under him having tokens with prime number values.
Input Format:
First line of the input contains N, the number of persons playing in the park
Second line contains token numbers assigned for the persons and they are separated by a space ith number in the line contains the value of the token assigned to the ith person.
Next N-1 lines contains two integers Xi and Yi separated by a space and indicates that Xi is the parent of Yi.
The next line contains the number of queries, Q
Next Q lines contain the person queried
```

As soon as we read the problem, we see that it screams trees, as a parent child hierarchical relationship, can 
be best represented using graphs.  

### Understanding the problem
Basically , after you're able to store all the data in appropriate data structures, the question  boils down to
this:
> Given a node, find the number of its children which  have prime number as their token values

### Approaches
There could be two approaches to solve the problem:

1. Top Down : For each query, start from the given node and do a DFS and find the answer. Linear time for each query.
2. Bottom Up : Before answering  any queries, go to the leaf nodes and bubble up all the answers for each
node and store beforehand. Now we can answer queries in constant time.
   
### Solution
I made a solution video explaining the bottom up approach:
<iframe width="1280px" height="720px" src="https://www.youtube.com/embed/pEwTw97BS2c" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Code
---
#### Python implementation for this problem
```python
import math
# Number of people
n = int(input())
tokens = [] # For storing tokens
tree = [] # For storing adjacency list in tree, check https://youtu.be/09zltCNaRF8 for more
result = [] # For storing the results


#Slightly improved logic to check if a number is prime or not
def isPrime(number):
    if(number <= 1): return False
    if(number <= 3): return True

    if(number % 2 == 0 or number % 3 == 0):
        return False
    
    for i in range(5, math.ceil(math.sqrt(number)) + 1, 6):
        if(number % i == 0 or (number % (i + 2) == 0)):
            return False

    return True

# Depth first traversal as explained:https://youtu.be/pEwTw97BS2c?t=340
def depth_first_traversal(source):
    for child in tree[source]:
        #Go deep into the branch
        depth_first_traversal(child)
    #While coming up, bubble up the results from children to the parent
    for child in tree[source]:
        if(isPrime(tokens[child-1])):
            result[source] += 1
        result[source] += result[child]

#Get all the tokens
tokens = list(map(int, input().split()))
#Initialise tree and results
for i in range(n+1):
    tree.append([])
    result.append(0)
#Store the tree as adjacency list
for i in range(n-1):
    x,y = map(int, input().split())
    tree[x].append(y)
#Perform depth first traversal and build the results list,
#this operation only needs to run once
depth_first_traversal(1)
#Answer all the queries
q = int(input())
for _ in range(q):
    x = int(input())
    print(result[x])

```
#### C++ implementation for the same:

```CPP
#include <iostream>
#include <vector>
using namespace std;

const int MAXN = 1e3+5;

int result[MAXN];

bool isPrime(int number) {
    if(number <= 1) return false;
    if(number <= 3) return true;

    if(number % 2 == 0 || number % 3 == 0) {
        return false;
    }

    for(int i = 5; i*i <= number; i+= 6) {
        if(number % i == 0 || number % (i+2) == 0) {
            return false;
        }
    }
    return true;
}

void depth_first_traversal(int source, vector<vector<int>>& tree, vector<int> tokens) {
    for(int child: tree[source]) {
        depth_first_traversal(child, tree, tokens);
    }
    for(int child: tree[source]) {
        if(isPrime(tokens[child-1])) {
            result[source] += 1;
        }
        result[source] += result[child];
    }
}


int main() {
    int n;
    cin>>n;
    int token;
    vector<int> tokens;
    vector<vector<int>> tree(n+1, vector<int>());   
    for(int i = 0; i < n; i++) {
        cin>>token;
        tokens.push_back(token);
    }
    int x, y;
    for(int i = 0; i < n-1; i++) {
        cin>>x>>y;
        tree[x].push_back(y);
    }
    depth_first_traversal(1, tree, tokens);
    int q;
    cin>>q;
    while(q--) {
        cin>>x;
        cout<<result[x]<<endl;
    }
    return 0;
}
```

