# Dart Chapter #3

날짜: 2024년 1월 11일
태그: Flutter

### Function

---

- 함수를 선언할 수 있는 다양한 방법
    - return 하는 것이 없다면 void로 지정
    - return 하는 것이 있다면 그에 맞는 type을 definition으로 지정
    - return과 중괄호 없이 `=>`을 통해 바로 return 값을 지정할 수 있다.

```bash
// return nothing because of type void
void sayHello(String name){
  print("hello $name nice to meet you");
}

// if you want return something we must update function definition.
String sayHello2(String name){
  return "hello $name nice to meet you";
}

// shortcut
// =>을 이용해 return과 중괄호를 생략하고 바로 선언할 수 있다 
String sayHello3(String name) => "hello $name nice to meet you";

num plus(num a, num b) => a + b;

// 무언가를 실행할 때는 무조건 main안에 있어야한다.
// 외부에서 선언한 것을 실행하는 것도 마찬가지 
void main() {
  sayHello('nico');
  print(sayHello2('nico'));
  print(sayHello3('nico'));
  print(plus(1, 2));
}
```

### Named Paramters

---

- **Positional parameter**
    - 이런 식으로 새로운 함수를 만들 수 있지만-.
    - 변수가 무엇인지 잊어버리기 쉽고 읽었을 때 바로 이해하기 쉽지 않다.

```dart
// 3 paramters
String sayHello(String name, int age, String country){
  return "Hello $name, you are $age, and you come from $country.";
}

// 무언가를 실행할 때는 무조건 main안에 있어야한다.
// 외부에서 선언한 것을 실행하는 것도 마찬가지 
void main() {
  print(sayHello('nico', 20, 'Spain'));

>> **Hello nico, you are 20, and you come from Spain.**
```

> ***⇒ named argument 사용하기!***
> 
> 
> **순서에 관계없이 argument의 이름들을 적어주는 것!**
> 
> 순서를 신경쓰지 않고 type에 올바른 값을 넣어주면 함수를 사용할 수 있다. 
> 
- *named argument*
    - 사용하는 방법은 인자를 dictionary처럼 넣어주는 것
    - 이를 위해서는 function definition을 수정해야 한다.
        - reason: user가 인자로 null을 넘겨 줄 수도 있기 때문이다.
        - Dart에서는 Null safty가 발동
            
            → null을 참조할 수 없도록 수정해주어야 한다.
            
        
        ***<Base> parameter 정의를 중괄호 `{}` 로 감싸준다.*** 
        
        No 1. function의 parameter에 default value를 지정해준다.
        
        No 2. 반드시 data를 받고 싶을 때 `required`라고 명시해준다. 
        
        → data를 받지 못하면 Dart가 함수 실행을 하지 않는다.
        

```dart
// 함수의 형태를 조금 바꾸어 주어야한다. 

// 1. default value 지정 
String sayHello(**{String name = 'anon', 
								int age = 19, 
								String country = 'Korea',}**){
  return "Hello $name, you are $age, and you come from $country.";
}

// 2. 변수마다 required 명시
String sayHello(**{required String name, 
                 required int age, 
                 required String country,}**){
  return "Hello $name, you are $age, and you come from $country.";
}

// 이런 식으로 변수에 무엇이 들어갈지 명세해주면 된다. 
// name: 'nico' -> ok 
// 'nico' -> not ok
void main() {
  print(sayHello(
    age: 12,
    country: 'Spain',
    name: 'nico'
		));
}
```

### Optional Positional Parameters

---

- named argument를 사용하고 싶지는 않은데 부분적으로 data를 받고 싶을 때(부분적으로 필수일 때)
- **받을 필요가 없는 변수의 definition에 대괄호 `[]` 를 씌워주고 null safty를 위해 `?` (내가 받고 싶은 변수가 있을 수도 있고 없을 수도 있으니까!)와 `default value`를 명시해준다.**

```dart
String sayHello(String name, 
                int age, 
                **[String? country = 'Spain']**)  
  => "Hello $name, you are $age years old from $country.";

void main(){
// named argument를 적용하고 싶지는 않은데 country는 반드시 받고 싶다.
  print(sayHello( 'nico', 20 ));
}

>> data에 country를 넣어주지 않아도 알아서 default value를 print하고 있다. 
>> Hello nico, you are 20 years old from Spain.

```

### QQ Operator

---

- 아래와 같은 함수에서 null을 받고 싶다고 `String?` 을 선언하면 error 발생

```dart
// 불가!!!!!!!!!!!
// toUpperCase 호출 불가
String capitalizeName(String? name) => name.toUpperCase();

void main(){
	capitalizeName('name');
	capitalizeName(null); //위와 같은 정의에서는 null을 입력 받을 수 없지만 이름으로 null을 받고 싶다. 
}
```

- 해결 방안 1

```dart
String capitalizeName(String? name) {
	// null이 아닐 때만 적용하게 한다. 
	if(name != null){
			return name.toUpperCase();
	}
	return 'ANON';
}
```

- 해결 방안 2**(fat arrow)**
    - 예전에 C++에서 하던 것과 유사
    - if(A ? B : C) → 만약 A라면 True일 때 B, False일 때 C

```dart
String capitalizeName(String? name) => name != null ? name.toUpperCase() : 'ANON';
```

- **해결 방안 3(QQ Operator)**

```dart
String capitalizeName(String? name) => name?.toUpperCase() **??** 'ANON';
```

<aside>
📌 ***QQ Operator***

> ***left ?? right***
> 

***if left is null, return right***

</aside>

- **QQ assignment operator**
    - 만약 name이 null 이라면 nico라는 값을 할당해 달라

```dart
String? name;

// means: if name is null, put a value nico to name
name **??=** 'nico';
```

### Typedef

---

> 자료형이 헷갈릴 때 도움이 될 alias를 만드는 방법
> 

```dart
**typedef ListOfInts = List<int>**

// parameter로 숫자 리스트를 입력 받음
**List<int>** reverseListOfNumbers(**List<int>** list){
	var reversed = list.reversed;
	return reversed.toList();
}

// typedef 를 사용한다면?
**ListOfInts** reverseListOfNumbers(**ListOfInts** list){
	var reversed = list.reversed;
	return reversed.toList();
}
```

```dart
// 아래 형태도 괜찮지만 구조화된 형태를 저장하고 싶다면 Class를 추천한다. 
**typedef UserInfo = Map<String, String>**

// string : string으로 쌍을 이루는 딕셔너리를 input으로 받겠다.
String sayHi(Map<String, String> userInfo) => "Hi ${userInfo['name']}"; 

// typedef 적용
=> String sayHi(**UserInfo** userInfo) => "Hi ${userInfo['name']}"; 

>> sayHi({"name" : "nico"});
>> Hi nico
```
