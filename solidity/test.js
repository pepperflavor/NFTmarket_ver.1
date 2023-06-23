// 두 배열의 요소 비교하기
let myArr = ["A", "B", "C", "D"];
let newArr = [];
let value;
for (let i = 0; i < myArr.length; i++) {
  value = myArr[i];
  newArr.push(value);
}

console.log(newArr);
// 두 배열이 같은지 확인해보려면? - join
// 배열내의 요소들을 string으로 합쳐준다
// join("") - 구분자 없이 하나로 합쳐줌

let joinArr1 = myArr.join(",");
let joinArr2 = myArr.join(",");

console.log("join1 : " + joinArr1);
console.log("join2 : " + joinArr2);

if (joinArr1 == joinArr2) {
  console.log("test succesful");
}
