<!--
 * @Author: xueyan
 * @Date: 2021-08-16 15:03:22
 * @LastEditTime: 2021-08-19 16:59:34
 * @LastEditors: Please set LastEditors
 * @Description: 流程图预览
 * @FilePath: /flow-template-front/src/components/package/bpmnViewer/index.vue
-->

<template>
  <div>
    <div class="bpmn-viewer-canvas" ref="bpmn-viewer-canvas"></div>
  </div>
</template>

<script>
  import { getModelXml, getModelNodeInfo } from '@/api/workmenu/sentmission.js'

  export default {
    name: 'bnmpViewer',
    props: {
      processInstanceId: {
        type: String
      }
    },
    data () {
      return {
        bpmnViewer: null,
        overlays: null,
        activeActivityIds: [], // 高亮节点
        highLightedFlows: [], // 高亮线
        events: ["element.click", "element.hover"],
        viewTypeList: ['bpmn:UserTask'], // 可显示的节点类型
        activityId: '', //当前正在查看哪个节点
        nodeInfo: {},
        nodeInfoList: [], // 已经获取到的节点信息
      }
    },
    created () {
    },
    watch: {
      processInstanceId: {
        handler(newVal) {
          this.empty();
          this.$refs['bpmn-viewer-canvas'].innerHTML='';
          if (newVal) {
            console.log(newVal)
            this.getData()
          }
        },
        deep: true
      }
    },
    methods: {
      async getData () {
        const res = await getModelXml(this.processInstanceId);
        this.activeActivityIds = res.data.activeActivityIds;
        this.highLightedFlows = res.data.highLightedFlows
        this.openDiagram(res.data.modelXml)
        // activeActivityIds 高亮节点
        // highLightedFlows 高亮线
        console.log('model,', res)
      },
      /**
       * Open diagram in our viewer instance.
       *
       * @param {String} bpmnXML diagram to display
       */
      async openDiagram(bpmnXML) {
        // import diagram
        try {
          this.bpmnViewer = new BpmnJS({
            container: this.$refs['bpmn-viewer-canvas']
          });
          this.initModelListeners();

          await this.bpmnViewer.importXML(bpmnXML);
          const canvas = this.bpmnViewer.get('canvas');
          canvas.zoom('fit-viewport');
          this.overlays = this.bpmnViewer.get('overlays');
          // access viewer components
          // var canvas = this.bpmnViewer.get('canvas');
          // var overlays = this.bpmnViewer.get('overlays');
          console.log('canvas', canvas)

          // zoom to fit full viewport
          // canvas.zoom('fit-viewport');

          // attach an overlay to a node
          // overlays.add('usertask1', 'note', {
          //   position: {
          //     bottom: 0,
          //     right: 0
          //   },
          //   html: '<div class="diagram-note"></div>'
          // });

          // add marker
          // 高亮节点
          this.activeActivityIds.forEach((item, index) => {
            canvas.addMarker(item, 'needs-discussion');
          })
          // 高亮线
          this.highLightedFlows.forEach((item, index) => {
            canvas.addMarker(item, 'needs-highlight');
          })

        } catch (err) {

          console.error('could not import BPMN 2.0 diagram', err);
        }
      },
      // 监听事件
      initModelListeners() {
        const EventBus = this.bpmnViewer.get("eventBus");
        console.log('EventBus', EventBus)
        const that = this;
        // 注册需要的监听事件, 将. 替换为 - , 避免解析异常
        this.events.forEach(event => {
          EventBus.on(event, async function(eventObj) {
            let eventName = event.replace(/\./g, "-");
            let element = eventObj ? eventObj.element : null;
            if (element.businessObject.id === that.activityId) {
              return ;
            } else {
              that.activityId = element.businessObject.id
            }
            $('.bpmn-tips').remove()

            // 获取当前节点的信息

            if (that.viewTypeList.indexOf(element.type) > -1) {
              console.log('事件触发', eventObj)
              await that.getNodeInfo()
              // element.id
              // const overlays = that.bpmnViewer.get('overlays');
              // <div class="text item">审批人员：${that.getPersonnel(element.businessObject)}</div>

              that.overlays.add(element.id, 'note', {
                position: {
                  bottom: 0,
                  right: 0
                },
                html: `
                <div class="bpmn-tips">
                  <div class="source">
                    <div>
                      <div class="el-card box-card is-always-shadow">
                        <div class="el-card__header">
                          <div class="clearfix">
                            <span>${that.nodeInfo?.name ?? '' }</span>
                          </div>
                        </div>
                        <div class="el-card__body">
                          <div class="text item">审批人员：${that.nodeInfo?.approver ?? ''}</div>
                          <div class="text item">节点类型： ${that.nodeInfo?.nodeType ?? ''}</div>
                          <div class="text item">节点状态： ${that.nodeInfo?.status ?? ''}</div>
                          <div class="text item">开始时间： ${that.nodeInfo?.startDate ?? ''}</div>
                          <div class="text item">结束时间： ${that.nodeInfo?.endDate ?? ''}</div>
                          <div class="text item">耗时： ${that.nodeInfo?.duration ?? ''}</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                `
              });
            }
            that.$emit(eventName, element, eventObj);
          });
        });
      },
      // 获取 审批人员list
      getPersonnel (businessObject) {
        let personnelList = [];
        let list = this.findFlowable(businessObject, 'flowable:idmAssignee')
        list.forEach((item, index) => {
          personnelList.push(item.nickName)
        })
        return personnelList.join(',')
      },
      // 查询xml里扩展的标签
      findFlowable (businessObject, key) {
        let val = businessObject?.extensionElements?.values.find((item) => {
          return item.$type === key
        })
        if (val) {
          return JSON.parse(val.$body)
        } else {
          return []
        }
      },
      // 获取节点信息
      async getNodeInfo () {
        if (this.activityId === this.nodeInfo.id) {
          return;
        }
        let list = this.nodeInfoList.filter((item, index) => {
          return item.id === this.activityId
        })
        if (list.length) {
          this.nodeInfo = list[0]
          return;
        }
        const res = await getModelNodeInfo(this.processInstanceId, this.activityId);
        if (res.data?.id === this.activityId) {
          this.nodeInfo = res.data
          // 去重存储到本地，防止恶意占用服务器资源
          this.nodeInfoList = Array.from(new Set([...this.nodeInfoList, res.data]))
        } else {
          this.nodeInfo = {}
        }
      },
      // 清除缓存方法
      empty () {
        $('.bpmn-tips').remove()
        this.activityId = '';
        this.nodeInfo = {};
        this.nodeInfoList = [];
      }
    }
  }
</script>

<style lang="scss" scoped>
  .bpmn-viewer-canvas {
    height: 50vh;
    padding: 0;
    margin: 0;
  }

</style>
<style lang="scss">
.bpmn-viewer-canvas {
  .bpmn-tips {
    /* z-index: 999;
    border-radius: 2px;
    border: 1px solid #999;
    font-family: Arial;
    font-size: 14px;
    padding: 5px;
    min-height: 16px; */
    width: 300px;
  }
  .item {
    margin-bottom: 18px;
  }
  .diagram-note {
    background-color: rgba(66, 180, 21, 0.7);
    color: White;
    border-radius: 5px;
    font-family: Arial;
    font-size: 12px;
    padding: 5px;
    min-height: 16px;
    width: 50px;
    text-align: center;
  }

  .needs-discussion:not(.djs-connection) .djs-visual > :nth-child(1) {
    stroke: rgba(66, 180, 21, 0.7) !important; /* color elements as green */
  }

  .needs-highlight .djs-visual > :nth-child(1) {
    stroke: rgba(66, 180, 21, 0.7) !important; /* color elements as green */
  }
}

</style>
