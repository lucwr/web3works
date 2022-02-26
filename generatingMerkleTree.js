// Use a node module called merkelTreejs
// there is a keccack256 library too
// csv parser => csv-parser
// fs=> allows you to write and read from files

// in js, you use require("ethers)
// import is used in modules in javascript
// but in typescript, you can use import 
// fs has 4 important fuction;
// 1. createReadStream => accepts a path to a file, 
// fs.createReadStream(filename).pipe(csv())
//.pipe => outputing data raw/ pushing raw data
// csv()=> the csv parser
// 2. fs.writeFile

const { MerkleTree } = require('merkletreejs')
const ethers = require('ethers').utils
const keccak256 = require('keccak256')

// console.log(ethers.solidityKeccak256(['string'],['str']))
const leaves = ['a', 'b', 'c'].map(x => ethers.solidityKeccak256(['string'],[x]))
// console.log(leaves)
const tree = new MerkleTree(leaves, keccak256, { sortPairs: true})
const root = tree.getRoot().toString('hex')
const leaf = ethers.solidityKeccak256(['string'],['a'])
const proof = tree.getProof(leaf)
// const readableProof = Buffer.from(proof).toString('hex')
// const readableProof = Buffer.from(proof)
console.log("proof", tree)
// console.log(tree.verify(proof, leaf, root)) // true

