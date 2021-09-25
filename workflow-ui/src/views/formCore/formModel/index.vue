<template>
  <div class="form-container">
    <fc-designer ref="designer"/>
  </div>
</template>

<script>
import formCreate from "@form-create/element-ui";


//FcDesigner 生成的`JSON`
const FcDesignerRule = '[\n' +
  '  {\n' +
  '    "type": "FcRow",\n' +
  '    "props": {\n' +
  '      "gutter": 4\n' +
  '    },\n' +
  '    "children": [\n' +
  '      {\n' +
  '        "type": "col",\n' +
  '        "props": {\n' +
  '          "span": 12\n' +
  '        },\n' +
  '        "children": [\n' +
  '          {\n' +
  '            "type": "input",\n' +
  '            "field": "mwh5samtjaud",\n' +
  '            "title": "输入框",\n' +
  '            "info": "",\n' +
  '            "props": {\n' +
  '              "maxlength": 164,\n' +
  '              "minlength": 0,\n' +
  '              "type": "text",\n' +
  '              "readonly": false\n' +
  '            },\n' +
  '            "_fc_drag_tag": "input",\n' +
  '            "hidden": false,\n' +
  '            "display": true,\n' +
  '            "validate": [\n' +
  '              {\n' +
  '                "trigger": "change",\n' +
  '                "mode": "",\n' +
  '                "message": "",\n' +
  '                "type": "string"\n' +
  '              }\n' +
  '            ]\n' +
  '          },\n' +
  '          {\n' +
  '            "type": "input",\n' +
  '            "field": "liq5samuq9va",\n' +
  '            "title": "输入框",\n' +
  '            "info": "",\n' +
  '            "_fc_drag_tag": "input",\n' +
  '            "hidden": false,\n' +
  '            "display": true\n' +
  '          }\n' +
  '        ],\n' +
  '        "_fc_drag_tag": "col",\n' +
  '        "hidden": false,\n' +
  '        "display": true\n' +
  '      },\n' +
  '      {\n' +
  '        "type": "col",\n' +
  '        "props": {\n' +
  '          "span": 12\n' +
  '        },\n' +
  '        "children": [\n' +
  '          {\n' +
  '            "type": "radio",\n' +
  '            "field": "s7x1luycykrtj",\n' +
  '            "title": "单选框",\n' +
  '            "info": "",\n' +
  '            "effect": {\n' +
  '              "fetch": ""\n' +
  '            },\n' +
  '            "props": {\n' +
  '              "textColor": "#666"\n' +
  '            },\n' +
  '            "options": [\n' +
  '              {\n' +
  '                "value": "1",\n' +
  '                "label": "选项1"\n' +
  '              },\n' +
  '              {\n' +
  '                "value": "2",\n' +
  '                "label": "选项2"\n' +
  '              }\n' +
  '            ],\n' +
  '            "_fc_drag_tag": "radio",\n' +
  '            "hidden": false,\n' +
  '            "display": true\n' +
  '          }\n' +
  '        ],\n' +
  '        "_fc_drag_tag": "col",\n' +
  '        "hidden": false,\n' +
  '        "display": true\n' +
  '      },\n' +
  '      {\n' +
  '        "type": "col",\n' +
  '        "props": {\n' +
  '          "span": 6,\n' +
  '          "offset": 3,\n' +
  '          "push": 1,\n' +
  '          "pull": 7\n' +
  '        },\n' +
  '        "_fc_drag_tag": "col",\n' +
  '        "hidden": false,\n' +
  '        "display": true\n' +
  '      },\n' +
  '      {\n' +
  '        "type": "col",\n' +
  '        "props": {\n' +
  '          "span": 12\n' +
  '        },\n' +
  '        "children": [\n' +
  '          {\n' +
  '            "type": "checkbox",\n' +
  '            "field": "3531luycs1jg7",\n' +
  '            "title": "多选框",\n' +
  '            "info": "",\n' +
  '            "effect": {\n' +
  '              "fetch": ""\n' +
  '            },\n' +
  '            "options": [\n' +
  '              {\n' +
  '                "value": "1",\n' +
  '                "label": "选项1"\n' +
  '              },\n' +
  '              {\n' +
  '                "value": "2",\n' +
  '                "label": "选项2"\n' +
  '              }\n' +
  '            ],\n' +
  '            "_fc_drag_tag": "checkbox",\n' +
  '            "hidden": false,\n' +
  '            "display": true\n' +
  '          }\n' +
  '        ],\n' +
  '        "_fc_drag_tag": "col",\n' +
  '        "hidden": false,\n' +
  '        "display": true\n' +
  '      },\n' +
  '      {\n' +
  '        "type": "col",\n' +
  '        "props": {\n' +
  '          "span": 12\n' +
  '        },\n' +
  '        "children": [\n' +
  '          {\n' +
  '            "type": "upload",\n' +
  '            "field": "4fr1luyd61qm6",\n' +
  '            "title": "上传",\n' +
  '            "info": "",\n' +
  '            "props": {\n' +
  '              "action": "",\n' +
  '              "onSuccess": "[[FORM-CREATE-PREFIX-function(e,t){t.url=e.data.url}-FORM-CREATE-SUFFIX]]"\n' +
  '            },\n' +
  '            "_fc_drag_tag": "upload",\n' +
  '            "hidden": false,\n' +
  '            "display": true\n' +
  '          }\n' +
  '        ],\n' +
  '        "_fc_drag_tag": "col",\n' +
  '        "hidden": false,\n' +
  '        "display": true\n' +
  '      }\n' +
  '    ],\n' +
  '    "_fc_drag_tag": "row",\n' +
  '    "hidden": false,\n' +
  '    "display": true\n' +
  '  }\n' +
  ']';

//FcDesigner 生成的`options`
const FcDesignerOptions = '{\n' +
  '  "form": {\n' +
  '    "inline": false,\n' +
  '    "labelPosition": "right",\n' +
  '    "size": "mini",\n' +
  '    "labelWidth": "125px",\n' +
  '    "hideRequiredAsterisk": false,\n' +
  '    "showMessage": true,\n' +
  '    "inlineMessage": false\n' +
  '  }\n' +
  '}';

export default {
  name: "FormModel",
  components: {
    formCreate
  },
  data() {
    return {
      fapi: null,
      rule: {},
      option: {},
    };
  },
  created() {
    this.rule = formCreate.parseJson(FcDesignerRule);
    this.option = formCreate.parseJson(FcDesignerOptions);
  },
  methods: {
    onSubmit (formData) {
      //todo 提交表单
    }
  }
};
</script>

<style lang="scss" scoped>

  .el-form {
    margin: 50px auto;
    padding: 50px;
    width: 580px;
    border: 1px solid gray;
    border-radius: 8px;
  }
</style>
