export class TodoItem {
  id: number;
  title: string;
  completed: boolean;
  createTime: string;

  constructor(title: string) {
    this.id = new Date().getTime();
    this.title = title;
    this.completed = false;
    this.createTime = new Date().toLocaleString();
  }
}


@Entry
@Component
struct Index {
  @State todoList: TodoItem[] = [
    new TodoItem('学习 ArkUI 框架'),
    new TodoItem('完成 OpenLab 考核'),
    new TodoItem('部署个人网站')
  ];

  @State newTodoTitle: string = '';

  addTodo() {
    if (this.newTodoTitle.trim().length > 0) {
      const newTodo = new TodoItem(this.newTodoTitle.trim());
      this.todoList.push(newTodo);
      this.newTodoTitle = '';
    }
  }

  toggleTodo(index: number) {
    this.todoList[index].completed = !this.todoList[index].completed;
  }

  deleteTodo(index: number) {
    this.todoList.splice(index, 1);
  }

  build() {
    Column({ space: 20 }) {
      Text('待办')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Row({ space: 10 }) {
        TextInput({
          placeholder: '输入新的待办事项...',
          text: this.newTodoTitle
        })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.newTodoTitle = value;
          })

        Button('添加')
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .onClick(() => {
            this.addTodo();
          })
      }
      .width('100%')
      .padding(10)

      List({ space: 10 }) {
        ForEach(this.todoList, (item: TodoItem, index: number) => {
          ListItem() {
            Row({ space: 15 }) {
              Image(item.completed ? $r('app.media.ok' +
                '') : $r('app.media.no' +
                ''))
                .width(24)
                .height(24)
                .onClick(() => {
                  this.toggleTodo(index);
                })

              Text(item.title)
                .fontSize(18)
                .decoration({
                  type: item.completed ? TextDecorationType.LineThrough : TextDecorationType.None
                })
                .fontColor(item.completed ? '#999' : '#000')
                .layoutWeight(1)

              Button('删除')
                .backgroundColor(Color.Red)
                .fontColor(Color.White)
                .fontSize(12)
                .onClick(() => {
                  this.deleteTodo(index);

                      })
            }
            .width('100%')
            .padding(15)
            .backgroundColor(Color.White)
            .borderRadius(8)
            .shadow({ radius: 2, color: '#00000016', offsetX: 0, offsetY: 1 })
          }
        }, (item: TodoItem) => item.id.toString())
      }
      .layoutWeight(1)
      .width('100%')

      Text(`总计: ${this.todoList.length} | 已完成: ${this.todoList.filter(item => item.completed).length}`)
        .fontSize(14)
        .fontColor(Color.Black)
        .margin({ top: 10 })

      Button('点个赞')
        .backgroundColor(Color.Orange)
        .fontColor(Color.White)
        .margin({ top: 20 })


    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F5F5F5')
  }
}

