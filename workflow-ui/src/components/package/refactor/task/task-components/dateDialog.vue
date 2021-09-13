<!--
 * @Author: xueyan
 * @Date: 2021-08-10 13:38:18
 * @LastEditTime: 2021-08-10 16:06:27
 * @LastEditors: Please set LastEditors
 * @Description: 选择到期时间弹窗  ISO8601格式
 * @FilePath: /flow-template-front/src/components/package/refactor/task/task-components/dateDialog.vue
-->
<template>
  <div>
    <el-dialog
      title="时间选择"
      :close-on-click-modal="false"
      :visible.sync="dialogVisible"
      width="800px">
      <div class="block">
        <label class="label">小时：</label>
        <el-radio-group v-model="hour" size="mini" @change="change('hour')">
          <el-radio-button :label="1"></el-radio-button>
          <el-radio-button :label="2"></el-radio-button>
          <el-radio-button :label="3"></el-radio-button>
          <el-radio-button :label="4"></el-radio-button>
        </el-radio-group>
        <el-button size="mini" v-show="!custom || !hour" @click="customClick('hour')">自定义</el-button>
        <el-input-number v-show="hour && custom" v-model="hour" @change="change('hour')" :min="0" :max="999" size="mini"></el-input-number>
      </div>
      <div class="block">
        <label class="label">天：</label>
        <el-radio-group v-model="day" size="mini" @change="change('day')">
          <el-radio-button :label="1"></el-radio-button>
          <el-radio-button :label="2"></el-radio-button>
          <el-radio-button :label="3"></el-radio-button>
          <el-radio-button :label="4"></el-radio-button>
        </el-radio-group>
        <el-button size="mini" v-show="!custom || !day" @click="customClick('day')">自定义</el-button>
        <el-input-number v-show="day && custom" v-model="day" @change="change('day')" :min="0" :max="999" size="mini"></el-input-number>
      </div>
      <div class="block">
        <label class="label">月：</label>
        <el-radio-group v-model="month" size="mini" @change="change('month')">
          <el-radio-button :label="1"></el-radio-button>
          <el-radio-button :label="2"></el-radio-button>
          <el-radio-button :label="3"></el-radio-button>
          <el-radio-button :label="4"></el-radio-button>
        </el-radio-group>
        <el-button size="mini" v-show="!custom || !month" @click="customClick('month')">自定义</el-button>
        <el-input-number v-show="month && custom" v-model="month" @change="change('month')" :min="0" :max="999" size="mini"></el-input-number>
      </div>
      <div class="block">
        <label class="label">年：</label>
        <el-radio-group v-model="year" size="mini" @change="change('year')">
          <el-radio-button :label="1"></el-radio-button>
          <el-radio-button :label="2"></el-radio-button>
          <el-radio-button :label="3"></el-radio-button>
          <el-radio-button :label="4"></el-radio-button>
        </el-radio-group>
        <el-button size="mini" v-show="!custom || !year" @click="customClick('year')">自定义</el-button>
        <el-input-number v-show="year && custom" v-model="year" @change="change('year')" :min="0" :max="999" size="mini"></el-input-number>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="close">取 消</el-button>
        <el-button type="primary" @click="ok">确 定</el-button>
      </span>
      
    </el-dialog>


  </div>
</template>
<script>
export default {
  props: {
    dialogVisible: Boolean,
    date: String
  },
  data() {
    return {
      hour: 0,
      day: 0,
      month: 0,
      year: 0,
      custom: false,// 自定义
    }
  },
  watch : {
    date (newVal) {
      if (newVal) {
        let list = newVal.split('');
        switch(list[2]) {
          case 'H':
            this.hour = list[1];
            break;
          case 'D':
            this.day = list[1];
            break;
          case 'M':
            this.month = list[1];
            break;
          case 'Y':
            this.year = list[1];
            break;
        }
      }
    }
  },
  methods: {
    close () {
      this.$emit('close')
    },
    ok () {
      let date = '';
      this.hour && (date=`P${this.hour}H`);
      this.day && (date=`P${this.day}D`);
      this.month && (date=`P${this.month}M`);
      this.year && (date=`P${this.year}Y`);

      this.$emit('ok', date)
    },
    customClick (key) {
      this.change(key)
      this[key] === 0 && (this[key] = 1)
      this.custom = true;
    },
    change (key) {
      key !== 'hour' && (this.hour = 0);
      key !== 'day' && (this.day = 0);
      key !== 'month' && (this.month = 0);
      key !== 'year' && (this.year = 0);
    }
  }
}
</script>
<style lang="scss" scoped>
.block {
  margin: 10px;
  .label {
    width: 60px;
    display: inline-block;
  }
}
</style>
