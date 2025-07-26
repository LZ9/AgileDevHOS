/**
 * 学生数据实体
 * Created by zhouL on 2025/7/26.
 */
export class StudentBean {
  /** 学号 */
  public id: number = 0
  /** 姓名 */
  public name: string = "";
  /** 年龄 */
  public age: number = 0;
  /** 城市 */
  public city: string = "";

  constructor(id: number, name: string, age: number, city: string) {
    this.id = id;
    this.name = name;
    this.age = age;
    this.city = city;
  }
  
}
