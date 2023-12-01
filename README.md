# iOS-MultipleTimers

## TabView Timer 구현

TabView에 여러 개의 타이머를 생성하고 원하는 Timer를 삭제할 수 있다.

---

### 실행화면

<img src = "https://github.com/bradheo65/TIL/assets/45350356/0c92cf5a-9fc9-47c8-ace5-ba58b51603bc" width = "300" height = "600">


### Timer 구현
먼저 Timer구현은 `Timer.publish`를 사용

```swift
 Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                print("Call Timer Publish")
            }
```
생성 시 , 1초마다 sink의 클로저를 실행시킨다.


### Model 추가
여러개의 Timer가 동작되야하기 떄문에 Array로 Timer를 관리하는게 좋을 것 같았다. 
Timer만 따로 관리하면 추적이 어려울 것 같아 Model을 만들어 하나로 관리하기 위해 Model을 만들었다.

```swift
import Foundation
import Combine

struct TimerItem: Identifiable {
    var id: UUID
    var count: Int
    var subscriptions: AnyCancellable?
}
```
Model 설명을 하자면, `id`는 각각의 Timer별로 고유아이디, `count`는 Timer를 이용해 값을 이용한 변수, `subscriptions` Timer이다.
초기엔 `idNumber`라는 변수를 두어 index로 구별했었지만, 중복된 정보인것같아, `id`로 각각의 Timer에 대해 접근한다.


### TabView 구현

- Array

```swift
 TabView(selection: $currentIndex) {
     ForEach(viewModel.timerItemStore, id: \.id) { item in
            VStack{
                HStack {
                    Text("ID: \(item.id)")
                        .lineLimit(2)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                Spacer()
                
                Text("Count: \(item.count)")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
            .foregroundColor(.white)
        }
    }
    .tabViewStyle(.page)
```

- index

```swift
TabView(selection: $currentIndex) {
    ForEach(0..<viewModel.timerItemStore.count, id: \.self) { index in
        VStack{
            HStack {
                Text("ID: \(viewModel.timerItemStore[index].id)")
                    .lineLimit(2)
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            Spacer()
            
            Text("Count: \(viewModel.timerItemStore[index].count)")
                .font(.title3)
                .fontWeight(.bold)
            
            Spacer()
        }
        .padding()
        .foregroundColor(.white)
    }
}
.tabViewStyle(.page)
```

영상을 보면 array Timer가 실행될떄마다(1초) TabView section이 0 즉 앞으로 계속 이동되고
index로 구현 시 section의 이동이 일어나지 않는다.
원인을 생각해보니, array로 구현 시 해당 데이터의 변화가 생기는 것이기에 다시 View를 그리기 떄문에 생기는 현상으로 생각된다.

|array|index|
|:---:|:---:|
|<img src = "https://github.com/bradheo65/TIL/assets/45350356/62e15754-cc6d-4269-8e06-c48a473f4433" width="300" height = "600">|<img src = "https://github.com/bradheo65/TIL/assets/45350356/5768b4af-7507-429e-9045-a44e4559093f" weight="300" height="600">|