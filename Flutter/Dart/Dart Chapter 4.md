# Dart Chapter #4

날짜: 2024년 1월 15일
태그: Flutter

### Your First Dart Class

---

Flutter의 모든 것은 Class

- class에서 property를 선언할 때는 타입을 사용해서 정의한다.
- **따라서 Class에서는 반드시 타입을 명시해주어야 한다.**

```dart
// class definition
class Player{
	String name = 'name';
	int xp = 1500;
}

// make class object
var player = Player(); //굳이 앞에 new를 쓸 필요 없다!
```

- 만든 객체에서 속성(property)를 **바꾸지 못하게 고정하고 싶으면** 어떻게 해야할까? `final`

```dart
class Player{
	**final** String name = 'name';
	int xp = 1500;
}
```

- ***Class function Definition***
    - `this` 를 사용해도 작동은 하나, 굳이 사용할 필요는 없다.
    - 속성과 변수의 이름이 겹친다면 `this` 를 명시해야 한다.

```dart
class Player{
	**final** String name = 'name';
	int xp = 1500;

	void sayHello(){
		print("Hi my name is **$name**"); 
	}
}
```

### Constructors

---

- 생성자 `Constructor` 를 이용해 다양한 value의 property를 가진 object를 만들어보자
- `**Contstructor`는 반드시 클래스의 이름과 동일해야 한다.**

```dart
class Player{
	// dart는 value가 없는 것을 싫어한다.
	// value는 이후 constructor에서 받아올 것이기 때문에 일단 선언만 하기 위하여 late를 붙인다.
	**late final** String name;
	**late** int xp;

	// 여기가 생성자!
	// 어떤 value를 input으로 받을지 명시 해주어야한다.
	**Player(String name, int xp){
		this.name = name;
    this.xp = xp;		
		}**
	void sayHello(){
		print("Hi my name is **$name**"); 
	}
}

// Make Object
var player = Player("nico", 1500);

```

- 더 효율적이고 나은 코드
    - 변수의 type을 일일히 넘겨주는 것은 번거로운 작업
    - **last 삭제, argument로 바로 this.variable을 넘겨준다.**

```dart
class Player{
	// dart는 value가 없는 것을 싫어한다.
	// value는 이후 constructor에서 받아올 것이기 때문에 일단 선언만 하기 위하여 late를 붙인다.
	**final** String name;
  int xp;

	// 어떤 value를 input으로 받을지 명시 해주어야한다.
	**Player(this.name, this.xp);**

	void sayHello(){
		print("Hi my name is **$name**"); 
	}
}

// Make Object
var player = Player("nico", 1500);
```

### Named Constructor Parameters

---

- class가 아주 클 때, argument의 position에 맞게 변수를 넘겨주는 것은 까다로울 수 있다.
- 순서대로 맞게 넘겨주는 것은 어렵고 value가 어떤 variable을 의미하는지 제대로 알기 힘들다.

```dart
class Player{
	// dart는 value가 없는 것을 싫어한다.
	// value는 이후 constructor에서 받아올 것이기 때문에 일단 선언만 하기 위하여 late를 붙인다.
	**final** String name;
  int xp;
	String team;
	int age;

	// 어떤 value를 input으로 받을지 명시 해주어야한다.
	// position is important
	**Player(this.name, this.xp, this.team, this.age);**

	void sayHello(){
		print("Hi my name is **$name**"); 
	}
}

// Make Object
var player = Player("nico", 1500, 'red', 12);
```

- ***해결 방법: Named Constructor Parameters***
    - Constructor 안에 있는 argument들을 `{}` 로 감싸준다.
    - **null safty를 위해 변수에 값을 지정해주거나 required 붙여주기**
        - required: 반드시 data를 받고 싶을 때 사용

```dart
class Player{
	// dart는 value가 없는 것을 싫어한다.
	// value는 이후 constructor에서 받아올 것이기 때문에 일단 선언만 하기 위하여 late를 붙인다.
	**final** String name;
  int xp;
	String team;
	int age;

//  이런 식으로도 변수 선언 가
//	final String name, team; //둘다 final로 선언
//  int xp age;

	// 어떤 value를 input으로 받을지 명시 해주어야한다.
	**// 중괄호로 감싸주기
	// null safty를 위해 값을 지정해주거나 required 붙여주기**
	**Player({required this.name, 
					required this.xp, 
					required this.team, 
					required this.age,});**

	void sayHello(){
		print("Hi my name is **$name**"); 
	}
}

**// Make Object
var player = Player(
	name: "nico", 
	xp: 1500, 
	team: 'red', 
	age: 12,);**
```

### Named Constructors

---

- 기존의 정의와 좀 다른 Constructor를 사용하고 싶다

```dart
class Player{
	// dart는 value가 없는 것을 싫어한다.
	// value는 이후 constructor에서 받아올 것이기 때문에 일단 선언만 하기 위하여 late를 붙인다.
	  final String name, team; //둘다 final로 선언
    int xp age;
	

	// 어떤 value를 input으로 받을지 명시 해주어야한다.
	// 중괄호로 감싸주기
	// null safty를 위해 값을 지정해주거나 required 붙여주기
	Player({required this.name, 
					required this.xp, 
					required this.team, 
					required this.age,});

	void sayHello(){
		print("Hi my name is $name"); 
	}
}
```

- 위와 같은 생성자로 아래와 같이 **property를 내가 정한 값으로 초기화 한 Object를 만들고 싶다.**
- 모든 variable에 대한 value가 아닌 name과 age에 대한 값을 주고 싶다.

```dart
>> var player = Player.createBluePlayer(
	name: 'nico',
	age: 21,
	);

>> var player = Player.createRedPlayer(
	name: 'nico',
	age: 21,
	);
```

- **생성자를 수정하자**

```dart
class Player{
	// dart는 value가 없는 것을 싫어한다.
	// value는 이후 constructor에서 받아올 것이기 때문에 일단 선언만 하기 위하여 late를 붙인다.
	  final String name, team; //둘다 final로 선언
    int xp age;
	

	// 어떤 value를 input으로 받을지 명시 해주어야한다.
	// 중괄호로 감싸주기
	// null safty를 위해 값을 지정해주거나 required 붙여주기
	Player({required this.name, 
					required this.xp, 
					required this.team, 
					required this.age,});

	// named constructor
	// player를 초기화 하는 메소드
	// 마지막에 :을 붙여야한다!
	// 여기서 받는 argument로 지역 변수를 초기화한다.
	**Player.createBluePlayer({required String name, requried in age}) :
	this.age = age,
	this.name = name,
	this.team = 'blue',
	this.xp = 0;                           NAMED 형식**
	
	**Player.createRedPlayer(String name, int age) :
	this.age = age,
	this.name = name,
	this.team = 'red',
	this.xp = 0;                            Poistional 형**

	void sayHello(){
		print("Hi my name is $name"); 
	}
}
```

### Cascade Notation

---

- 이미 선언한 Object의 property를 바꾸고 싶어요~
- 그러나 그 작업들이 반복적, 연속적 → 한번에 바꾸기

```dart
class Player{
	// dart는 value가 없는 것을 싫어한다.
	// value는 이후 constructor에서 받아올 것이기 때문에 일단 선언만 하기 위하여 late를 붙인다.
	String name;
  int xp;
	String team;
	int age;

	Player({required this.name, 
					required this.xp, 
					required this.team, 
					required this.age,});

	void sayHello(){
		print("Hi my name is **$name**"); 
	}
}

// Make Object
var player = Player(name: "nico", xp: 1500, team: 'red', age: 12,);

// 선언한 object의 속성을 바꾸고 싶다면?
// 그러나 너무 연속적, 반복적
**// Use cascade**
player.name = 'las';
player.xp = 1200;
player.team = 'blue;
```

- ***Cascade***

```dart
// 선언할 때 사용한 세미콜론 지우기!
var player = Player(name: "nico", xp: 1500, team: 'red', age: 12,) ****
**// Use cascade**
..name = 'las'
..xp = 120000
..team = 'blue
..sayHello() ;
```

### Enums

---

- 변수에 값을 잘못 넣는 경우가 존재할거야
- 이런 실수를 방지하게 해주는 것이 ***Enums!***
- 선택의 폭을 좁혀주는 역할을 한다.

```dart
// String 임에도 불구하고 큰 따옴표로 쓸 필요가 없다.
enum Team {red, blue} **-> 새롭게 지정한 타입이 되는 것이다.** 

class Player{
	// dart는 value가 없는 것을 싫어한다.
	// value는 이후 constructor에서 받아올 것이기 때문에 일단 선언만 하기 위하여 late를 붙인다.
	String name;
  int xp;
	**Team** team; -> 이제 team은 red와 blue. 2개의 옵션 중 하나가 된다.
	int age;
}

만약 property의 수정을 진행할 때는!
var player = Player(name: "nico", xp: 1500, team: 'red', age: 12,) ****
..name = 'las'
..xp = 120000
..team = Team.blue; //이런 식으로 접근해주어야 
```

### Abstract Classes

---

- 추상화 클래스
- **추상화 클래스로는 절대 객체를 생성 할 수 없다.**
- 다른 클래스들이 직접 구현해야하는 메소드들을 모아 놓은 것이다.
- **이를 정의할 때는 행동을 정의한다기 보단 그 메소드의 시그니처가 무엇인지 정의한다. → Which type will return?**

```dart
abstract class Human{
	void walk();
}
```

- ***How to use?***
    - 클래스 이름 뒤에 `extend {추상 클래스 명}` 을 붙여준다.
        - `extend` : 상속, 확장
    - 추상 클래스 안에 정의된 function은 extend하면 class 정의에서 추가로 정의해야 한다.

```dart
class Player **extends Human**{
	String name;
  int xp;
	String team; -> 이제 team은 red와 blue. 2개의 옵션 중 하나가 된다.
	int age;

	void walk(){
	print('walk');
	}
}
```

- 추상화 클래스는 이를 상속받는 모든 클래스가 가지고 있어야 하는 메소드를 정의한다.
- **이를 상속받고 각자의 class에서 그 속의 함수를 상속 받지만 함수의 내용은 다르게 구현할 수도 있다.**

### Inheritance

---

- 상속
- 기본 base가 될 Human class 정의

```dart
// 기본base가 될 Human class 정의
class Human{
	final String name;
	Human(required this.name); 
	void sayHello(){
		print("Hi my name is $name");
	}
}
```

> **Base가 되는 Class에 있는 “모든” 것을 상속 받을 Class에 가져온다.**
> 
- 상속 받을 Player, Coach Class 정의
- `**super` 이라는 키워드는 부모 class와 상호작용하게 해준다.**
- 상속 받은 메서드를 자식 class에서 custom 할 수 있다.
    - 자식 클래스에서 부모 클래스를 부를 때는 `super` 을 통해 부모 클래스의 메서드를 사용할 수 있다.

```dart
enum Team {red, blue}

class Player extends Human{
//enum을 통해 이미 지정된 값으로만 초기화 가능
// final 이기에 아무도 변경 못함
	fianl	Team team; 
	
**// 상속 받기 때문에 Human의 모든 method, property들을 가져옴
	Player({
		required this.team,
//여기서 이름은 현재 Human에게 있는 것!
//따라서 여기에서 받은 것을 다시 Human에게 주어야한다. 
		required String name 
// player에서 받은 이름은 super를 통해 넘어가게 된다.
	}) : super(name : name);**

 // 메서드 custom하기
		@override //여기서 정의한 것으로 덮어쓰기
		void sayHello(){
			super.sayHello() // 부모 class의 메소드 가져오기!
			print('and I play for ${team}');
		}
}
```

- Object 생성하기
    - 생성한 객체에서 상속받은 메서드를 사용할 수 있다.

```dart
var player = Player(name: "nico", xp: 1500, team: 'red', age: 12,);

// 생성한 객체에서 상속받은 메서드를 사용할 수 있다.
player.sayHello();

```

- 주의 사항

<aside>
📌 **상속 시 주의할 점**

확장한 부모 클래스가 생성자를 포함하고 있다면 상속받기 위해서는 해당 값을 넘겨주어야한다. 이후 그 부모 클래스의 생성자를 호출해준다. 자식 클래스에서 `super` 을 통해 넘겨주어야 한다.

```dart
// argument를 받아야 하는 부모 class의 생성자
**Human(required this.name);

// 부모 class를 사용하기 위해 super를 통해 필요한 argument를 넘겨주는 모습
: super(name : name);**
```

```dart
// 아래처럼 더 간단히 사용할 수도 있다. 
**Human(this.name);

: super(name);**
```

</aside>

### Mixins

---

- **생성자가 없는 Class**
- Class에 property들을 추가할 때 사용한다.
- 여러 클래스에 재사용이 가능하다.

```dart
// 생성자가 없는 class
class Strong{
	final double strenghtLevel = 1500.99;
}

class QuickRunner{
	void runQuick(){
		print('Runnnnnnnnnnnn');
	}
}

class Tall{
	final double height = 1.99;
}
```

**→ 이런 생성자가 없는 Class를 내 기존 Class에 적용하고 싶다!**

> ***with***
> 
> 
> 상속 받을 때는 `extends`를 썼지만 Mixin을 쓰기 위해서 `with`을 사용한다. 
> 
> 다른 class의 property와 method를 긁어와서 사용하는 것
> 

```dart
class Player with Strong, QuickRunner, Tall{
	String name;
  int xp;
	String team;
	int age;
}

//재사용 가능!
class Kid with Strong, QuickRunner, Tall{}
```
