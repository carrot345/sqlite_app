class Students {
  int? id; //있을수도 없을 수도 있다. 입력할때 id는 없을 수도 있어서 옵셔널?
  String code;
  String name;
  String dept;
  String phone;

  Students(
      {this.id,
      required this.code,
      required this.name,
      required this.dept,
      required this.phone});

  // factory Students.fromMap(Map<String,dynamic> res){//dart version 2에서 이렇게 만들어지는것을 factory라고 한다.맵타입으로 가져오는 타입이 res다.
  //   return Students(
  //     id: res['id'],
  //     code: code['code'],
  //     name: name['name'],
  //     dept: dept['dept'],
  //     phone: phone['phone']
  //     );
  // }
  // factory Students.fromMap(Map<String,dynamic> res)=> Students(//version 3. 이렇게 만들어지는것을 factory라고 한다.맵타입으로 가져오는 타입이 res다.

  //     id: res['id'],
  //     code: code['code'],
  //     name: name['name'],
  //     dept: dept['dept'],
  //     phone: phone['phone']
  //     );
  Students.fromMap(
      Map<String, dynamic>
          res) //이렇게 만들어지는것을 factory라고 한다.맵타입으로 가져오는 타입이 res다. 검색할때만 쓰는 것이다.

      : id = res['id'],
        code = res['code'],
        name = res['name'],
        dept = res['dept'],
        phone = res['phone'];
}
