
#  RxSwift 정리

## Observable, Observer, Subscribe
### 예시
- 계산기에서 숫자 3을 누름(observable: 이벤트 발생 및 전달)
- 화면에 3을 표시함(observer: 이벤트를 전달 받아서 이벤트를 처리함)
- 3을 눌렀다는 동작을 전달(subscribe: 구독을 해야 이벤트를 받을 수 있다)
<br/>

## Observable, Observer, Subscribe
1. Observable: event를 전달
2. Observer: event를 받아서 처리
    - Observable에게 Observer가 없다면 의미 없음

#  RxSwift 정리

## Observable, Observer, Subscribe
### 예시
- 계산기에서 숫자 3을 누름(observable: 이벤트 발생 및 전달)
- 화면에 3을 표시함(observer: 이벤트를 전달 받아서 이벤트를 처리함)
- 3을 눌렀다는 동작을 전달(subscribe: 구독을 해야 이벤트를 받을 수 있다)

## Observable, Observer, Subscribe
1. Observable: event를 전달
2. Observer: event를 받아서 처리
    - Observable에게 Observer가 없다면 의미 없음
    - 나중에 observer가 생길 수 있고, 생긴 시점 이후로 이벤트를 처리할 수 있다.
3. Subscribe: 구독을 해야 이벤트를 받을 수 있다, 즉 이벤트를 계속 관찰한다.
    - Observable <-(Subscribe / Dispose) -> Observer
    - Observable에게 Observer가 없으면? Subscribe하지 않아서 아무것도 할 수 없다
    - Observer가 나중에 생긴다면? 나중에 Subscribe해서 그 이후부터 이벤트를 처리할 수 있다.
    - Observer가 나중에 없어진다면? 처리해왔던 이벤트들을 앞으로는 처리할 수 없다. dispose.
 
<br/>

## Observable Sequence, Event, Operator
4. Observable Sequence: 이벤트를 전달한다 == 이벤트를 방출한다
4-1. infinite observable sequences - 횟수 상관 없이 무한대로 지원, 주로 UI
4-2. finite observable sequences - 끝이 있는 이벤트 전달
4-3. 이벤트 전달 방식
    - emit(방출) - next : 데이터를 쪼개서 받음, 주로 UI
    - notification - error: 네트워크 연결 유실, 다운로드 실패, 상태코드 오류
    - notification - complete: 다운로드 완료
5. 이벤트를 전달할 때 필터링을 해서 전달할 수 있음
    - just: 그냥 다 보내주세요~
    ```swift
    func testJust() {
        Observable    // 나 일 벌릴게
            .just([1,2,3])  // just로 일 벌릴게 - finite observable sequence
            .subscribe { value in  // observable을 subscribe한 observer에게 값을 emit할게
                                   // observer는 Observable의 subscribe 함수 내에 정의되어 있음
                print("next: \(value)")  // next는 이벤트를 emit
            } onError: { error in
                print("error")           // next를 하다 중간에 error를 만나면 -> error -> disposed
            } onCompleted: {
                print("complted")        // next가 끝나면 complte -> disposed
            } onDisposed: {
                print("disposed")        // deinit되는 시점, sequence가 종료되는 시점에 dispose됨
            }
            .disposed(by: disposeBag)
    }
    ```
    - from
    - interval: Infinite Observable Sequence
        - 명확한 끝이 없기 때문에 언제끝날지 몰라 error, complte, dispose도 발생하지 않음

## subscribe가 아니라 bind를 하는 이유는??
6. RxCocoa: RxSwift를 기반으로 UIKit을 래핑한 것, 주로 UI관련
```swift
items
.bind(to: tableView.rx.items) { (tableView, row, element) in
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
    
    cell.textLabel?.text = "\(element) @ row \(row)"
    return cell
}
.disposed(by: disposeBag)
```
- UI관련으로는 RxCocoa의 bind를 사용한다.
- error, complted를 생략해서 안 쓰는 것과 애초에 동작하지 않는 것은 다름.
- bind를 사용하면 main 스레드에서 동작하고 + error, complte를 매개변수로 갖고 있지 않음.
- 또한 내부에서 [weak self]를 매핑해준다.
    - 나중에 observer가 생길 수 있고, 생긴 시점 이후로 이벤트를 처리할 수 있다.
3. Subscribe: 구독을 해야 이벤트를 받을 수 있다, 즉 이벤트를 계속 관찰한다.
    - Observable <-(Subscribe / Dispose) -> Observer
    - Observable에게 Observer가 없으면? Subscribe하지 않아서 아무것도 할 수 없다
    - Observer가 나중에 생긴다면? 나중에 Subscribe해서 그 이후부터 이벤트를 처리할 수 있다.
    - Observer가 나중에 없어진다면? 처리해왔던 이벤트들을 앞으로는 처리할 수 없다. dispose.
 
<br/>

## Observable Sequence, Event, Operator
4. Observable Sequence: 이벤트를 전달한다 == 이벤트를 방출한다
4-1. infinite observable sequences - 횟수 상관 없이 무한대로 지원, 주로 UI
4-2. finite observable sequences - 끝이 있는 이벤트 전달
4-3. 이벤트 전달 방식
    - emit(방출) - next : 데이터를 쪼개서 받음, 주로 UI
    - notification - error: 네트워크 연결 유실, 다운로드 실패, 상태코드 오류
    - notification - complete: 다운로드 완료
5. 이벤트를 전달할 때 필터링을 해서 전달할 수 있음
    - just: 그냥 다 보내주세요~
    ```swift
    func testJust() {
        Observable    // 나 일 벌릴게
            .just([1,2,3])  // just로 일 벌릴게 - finite observable sequence
            .subscribe { value in  // observable을 subscribe한 observer에게 값을 emit할게
                                   // observer는 Observable의 subscribe 함수 내에 정의되어 있음
                print("next: \(value)")  // next는 이벤트를 emit
            } onError: { error in
                print("error")           // next를 하다 중간에 error를 만나면 -> error -> disposed
            } onCompleted: {
                print("complted")        // next가 끝나면 complte -> disposed
            } onDisposed: {
                print("disposed")        // deinit되는 시점, sequence가 종료되는 시점에 dispose됨
            }
            .disposed(by: disposeBag)
    }
    ```
    - from
    - interval: Infinite Observable Sequence
        - 명확한 끝이 없기 때문에 언제끝날지 몰라 error, complte, dispose도 발생하지 않음
<br/>

## subscribe가 아니라 bind를 하는 이유는??
6. RxCocoa: RxSwift를 기반으로 UIKit을 래핑한 것, 주로 UI관련
```swift
items
.bind(to: tableView.rx.items) { (tableView, row, element) in
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
    
    cell.textLabel?.text = "\(element) @ row \(row)"
    return cell
}
.disposed(by: disposeBag)
```
- UI관련으로는 RxCocoa의 bind를 사용한다.
- error, complted를 생략해서 안 쓰는 것과 애초에 동작하지 않는 것은 다름.
- bind를 사용하면 main 스레드에서 동작하고 + error, complte를 매개변수로 갖고 있지 않음.
- 또한 내부에서 [weak self]를 매핑해준다.
<br/>

## Stream 끊기: Disposable
- Subscribe 중인 Stream을 원하는 시기에 처리(정리)할 수 있도록 도와준다.
    - Observable은 모두 Disposable을 Return한다. 이를 통해 Stream을 종료하고, 실행되고 있던 Sequence를 모두 종료한다.
    - finite observable sequence의 경우에는 next 이벤트에 대한 emit이 끝나면 completed를 거쳐 disposed로 sequence가 정상적으로 종료됨, error 이벤트가 전달되더라도 disposed로 sequence가 종료됨
    - infinite observable sequence처럼 next 이벤트가 무한히 emit이 될 수 있는 상황에서는 disposed 되지 않음

### disposed되지 않는 다면?
- 계속 메모리에 남아 있게 된다.
#### 해결방법 1) .disposed(by: disposeBag)
- DisposeBag 클래스가 deinit될 때 dispose 메서드가 호출되면 별도의 액션을 취하지 않다라도 리소스 정리가 이루어진다.
-> VC가 deinit되면(= 프로퍼티들이 다 잘 정리되었을 때) disposeBag은 메모리에서 사라질 수 있다.
#### 해결방법 2) .dispose()
- Observer가 실행되지 않고 바로 onDisposed 상태를 거쳐 sequence가 종료됨
### rootView는 deinit될 수 없는데?!? Observable이 계속 살아 있으면 어떻게 하지??
- DispatchQueue.main으로 원하는 시점에 직접 종료(dispose)하는 방법
```swift
// 원하는 시점에 직접 종료
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    observer.dispose()
}
// 하지만 일일이 observable을 분리해서 dispose 시키는 것은 힘들다 => DisposeBag
```
-  DisposeBag으로 한 번에 리소스 정리하기
```swift
DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
     self.disposeBag = DisposeBag() // 쓰레기통 비우기
}
// 구독하는 객체가 여러 개 존재한다면, 일일이 필요한 시점에 모든 구독을 종료하는 것은 힘들다.
// DisposeBag의 인스턴스를 초기화 하는 과정을 통해 한 번에 리소스를 정리할 수 있다.
```
<br/>

## Observable + Observer = Subject
- Observable과 Observer를 통해 Stream(데이터의 흐름)을 통제할 수 있고, Operator를 통해 Stream을 변경, 조작할 수 있다.
- Observable은 이벤트를 방출(emit)만 / Observer는 이벤트를 전달 받아서 처리만
    - Observable에는 이벤트를 전달할 수 없다.
    - Observer은 받은 이벤트를 다른 Observer에게 전달할 수 없다.
### Observable과 Observer의 역할을 동시에할 수 있는 친구가 필요하다: Subject
- 이벤트를 전달할 수도 있고, 이벤트를 전달받아 처리할 수도 있다.
![image](https://hackmd.io/_uploads/S1lrPRDYC.png)
- BehaviorSubject
- PublishObject
- ReplaySubject
- AsnycSubject

#### BehaviorSubject: 초기값이 무조건 존재
- subscribe 이전에 emit한 이벤트가 없다면 초기값을 전달
```swift
var behavior = BehaviorSubject(value: 100) // 보낼수도 받아서 처리할수도

func testBehaviorSubject() {
    
    //구독이 일어나기 전에 behavior는 observable의 역할에 가까움
    behavior.onNext(1)
    behavior.onNext(2)
    behavior.onNext(3)  // 가장 최근에 전달된 이벤트 하나를 전달받을 수 있다.
    
    behavior
        .subscribe { value in
            print("behavior next - \(value)")
        } onError: { error in
            print("behavior error")
        } onCompleted: {
            print("behavior complete")
        } onDisposed: {
            print("behavior ondisposed")
        }
        .disposed(by: disposeBag)

    behavior.onNext(4)
    behavior.onNext(5)
    behavior.onNext(6)   
}

//behavior next - 3
//behavior next - 4
//behavior next - 5
//behavior next - 6

-> behavior next 100, 1, 2가 출력되지 않는 이유
: Observer가 Observable을 아직 구독하고 있지 않기 때문
-> 3이 출력되는 이유
: behavior는 초기값이 무조건 존재한다. 그래서 마지막 값인 3을 가지고 구독
```

#### PublishSubject
- 초기값이 없다. subscribe 이후 시점부터 emit되는 이벤트를 처리할 수 있다.
```swift
var publish = PublishSubject<Int>()

private func testPublishSubject() {
    
    //구독이 일어나기 전에 behavior는 observable의 역할에 좀 더 가까움
    publish.onNext(1)
    publish.onNext(2)
    publish.onNext(3)
    
    
    publish
        .subscribe { value in
            print("publish next - \(value)")
        } onError: { error in
            print("publish error")
        } onCompleted: {
            print("publish complete")
        } onDisposed: {
            print("publish ondisposed")
        }
        .disposed(by: disposeBag)
    
    publish.onNext(4)
    publish.onNext(5)
        publish.onCompleted()
    publish.onNext(6)
    
}

//publish next - 4
//publish next - 5
//publish complete
//publish ondisposed

-> 초기값을 가지고 있지 않기 때문에 3이 출력되지 않음
```
