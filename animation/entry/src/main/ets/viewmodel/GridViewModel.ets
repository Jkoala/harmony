import { CommonConstants } from '../common/constants/CommonConstants';
import { GridItemData } from '../common/bean/GridItemData';
import { GridAreaContent } from '../common/bean/GridAreaContent';

const PRE = "pages/sub/page"

/**
 * Get the app index in bundleInfoList.
 */
export class GridViewModel {
  /**
   * Get the grid items.
   *
   * @param {number} dataCount
   * @return {Array<GridItemData>} gridItems
   */
  private getGridItems(dataCount: number): Array<GridItemData> {
    let gridItems: Array<GridItemData> = [];
    for (let index = 0; index < dataCount; index++) {
      let gridItem = new GridItemData();
      gridItem.image = $r('app.media.ic_grid_item');
      gridItem.title = $r('app.string.grid_item_text');
      gridItem.url = PRE + index.toString();
      gridItems.push(gridItem);
    }
    return gridItems;
  }

  /**
   * Get top grid area data.
   *
   * @return {GridAreaContent} gridAreaContents
   */
  getTopGridAreaData(): GridAreaContent {
    let gridAreaContent = new GridAreaContent();
    gridAreaContent.gridItems = this.getGridItems(CommonConstants.TOP_GRID_COUNT);
    return gridAreaContent;
  }

  /**
   * Get bottom grid area data.
   *
   * @return {GridAreaContent} gridAreaContents
   */
  getBottomGridAreaData(): GridAreaContent {
    let gridAreaContent = new GridAreaContent();
    gridAreaContent.gridItems = this.getGridItems(CommonConstants.BOTTOM_GRID_COUNT);
    return gridAreaContent;
  }
}

let gridViewModel = new GridViewModel();

export default gridViewModel as GridViewModel;