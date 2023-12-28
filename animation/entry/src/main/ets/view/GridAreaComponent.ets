import { CommonConstants } from '../common/constants/CommonConstants';
import { GridAreaContent } from '../common/bean/GridAreaContent';
import type { GridItemData } from '../common/bean/GridItemData';
import GridModel from '../model/GridModel';
import router from '@ohos.router';
import hilog from '@ohos.hilog';

/**
 * GridView component display and layout.
 */
@Component
export struct GridAreaComponent {
  private gridAreaContent: GridAreaContent;
  private isShowTitle: boolean;
  @State private currentBreakpoint: string = CommonConstants.BREAK_POINT_SM;

  build() {
    GridRow({
      breakpoints: { value: CommonConstants.BREAK_POINT },
      columns: {
        sm: CommonConstants.COLUMN_SM,
        md: CommonConstants.COLUMN_MD,
        lg: CommonConstants.COLUMN_LG
      }
    }) {
      GridCol({
        span: {
          sm: CommonConstants.SPAN_SM,
          md: CommonConstants.SPAN_MD,
          lg: CommonConstants.SPAN_LG
        },
        offset: {
          lg: CommonConstants.OFFSET_LG
        }
      }) {
        Column() {
          if (this.isShowTitle) {
            Text($r('app.string.grid_content_text'))
              .textAlign(TextAlign.Start)
              .fontSize($r('app.float.sub_text_size'))
              .fontWeight(CommonConstants.TEXT_FONT_WEIGHT)
              .fontColor($r('app.color.grid_text'))
              .width(CommonConstants.TEXT_WIDTH_PERCENT)
              .height($r('app.float.grid_text_height'))
          }

          Grid() {
            ForEach(this.gridAreaContent.gridItems, (item: GridItemData) => {
              GridItem() {
                this.GridItemView(item)
              }
            }, (item, index) => index + JSON.stringify(item))
          }
          .columnsTemplate(GridModel.getColumnsTemplate(this.currentBreakpoint))
          .height(GridModel.getGridHeight(this.gridAreaContent.gridItems.length, this.currentBreakpoint))
          .hitTestBehavior(HitTestMode.None)
          .padding({
            bottom: $r('app.float.grid_padding_bottom')
          })
        }
      }
    }
    .onBreakpointChange((currentBreakpoint: string) => {
      this.currentBreakpoint = currentBreakpoint;
    })
  }

  @Builder GridItemView(item: GridItemData) {
    Flex({
      direction: FlexDirection.Column,
      alignItems: ItemAlign.Center,
      justifyContent: FlexAlign.Center
    }) {
      Image(item.image)
        .objectFit(ImageFit.Contain)
        .width($r('app.float.image_width'))
        .height($r('app.float.image_height'))
        .onClick(()=>{
          router.pushUrl({url:item.url}).then(()=>{
            hilog.info(1,CommonConstants.LOG_TAG,`forward ${item.url} success`);
          }).catch(()=>{
            hilog.error(1,CommonConstants.LOG_TAG,"forward ${item.url} failed");
          })
        })

      Text(item.title)
        .height($r('app.float.grid_item_text_height'))
        .fontSize($r('app.float.grid_item_text_size'))
        .fontWeight(CommonConstants.GRID_ITEM_FONT_WEIGHT)
        .fontColor($r('app.color.grid_text'))
        .align(Alignment.Center)
        .margin({
          top: $r('app.float.grid_text_margin_top'),
          bottom: $r('app.float.grid_text_margin_bottom')
        })
    }
    .width($r('app.float.grid_item_width'))
    .height($r('app.float.grid_item_height'))
    .padding({ top: $r('app.float.grid_item_padding_top') })
  }
}