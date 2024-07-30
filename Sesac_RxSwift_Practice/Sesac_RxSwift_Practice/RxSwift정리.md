
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
