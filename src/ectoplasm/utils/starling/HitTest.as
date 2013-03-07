package ectoplasm.utils.starling {

  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.geom.ColorTransform;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.geom.Rectangle;

  import starling.core.Starling;
  import starling.display.DisplayObject;

  /**
  * Borrowed from: http://forum.starling-framework.org/topic/solved-pixel-perfect-collision-detection-between-2-movieclip-in-starling
  */
  public class HitTest {

    public static function complexHitTestObject(target1:DisplayObject, target1BitmapData:BitmapData, target2:DisplayObject, target2BitmapData:BitmapData, accurracy:Number = 1):Boolean {
      return complexIntersectionRectangle(target1, target1BitmapData, target2, target2BitmapData, accurracy).width != 0;
    }

    public static function intersectionRectangle(target1:DisplayObject, target2:DisplayObject):Rectangle {
      // If either of the items don't have a reference to stage, then they are not in a display list
      // or if a simple hitTestObject is false, they cannot be intersecting.
      if (!target1.root || !target2.root || !simpleHitTestObject(target1, target2))
        return new Rectangle();

      // Get the bounds of each DisplayObject.
      var bounds1:Rectangle = target1.getBounds(target1.root);
      var bounds2:Rectangle = target2.getBounds(target2.root);

      // Determine test area boundaries.
      var intersection:Rectangle = new Rectangle();
      intersection.x = Math.max(bounds1.x, bounds2.x);
      intersection.y = Math.max(bounds1.y, bounds2.y);
      intersection.width = Math.min((bounds1.x + bounds1.width) - intersection.x, (bounds2.x + bounds2.width) - intersection.x);
      intersection.height = Math.min((bounds1.y + bounds1.height) - intersection.y, (bounds2.y + bounds2.height) - intersection.y);

      return intersection;
    }

    public static function complexIntersectionRectangle(target1:DisplayObject, target1BitmapData:BitmapData, target2:DisplayObject, target2BitmapData:BitmapData, accurracy:Number = 1):Rectangle {
      if (accurracy <= 0) {
        throw new Error("ArgumentError: Error #5001: Invalid value for accurracy", 5001);
      }
      // If a simple hitTestObject is false, they cannot be intersecting.
      if (!simpleHitTestObject(target1, target2))
        return new Rectangle();

      var hitRectangle:Rectangle = intersectionRectangle(target1, target2);
      // If their boundaries are no interesecting, they cannot be intersecting.
      if (hitRectangle.width * accurracy < 1 || hitRectangle.height * accurracy < 1)
        return new Rectangle();

      var bitmapData:BitmapData = new BitmapData(hitRectangle.width * accurracy, hitRectangle.height * accurracy, false, 0x000000);
      var testBitmapData:BitmapData = new BitmapData(hitRectangle.width * accurracy, hitRectangle.height * accurracy, false, 0);
      // Draw the first target.
      //bitmapData.draw(target1, HitTest.getDrawMatrix(target1, hitRectangle, accurracy), new ColorTransform(1, 1, 1, 1, 255, -255, -255, 255));
      bitmapData.draw(target1BitmapData, HitTest.getDrawMatrix(target1, hitRectangle, accurracy), new ColorTransform(1, 1, 1, 1, 255, -255, -255, 255));
      // Overlay the second target.
      //bitmapData.draw(target2, HitTest.getDrawMatrix(target2, hitRectangle, accurracy), new ColorTransform(1, 1, 1, 1, 255, 255, 255, 255), BlendMode.DIFFERENCE);
      bitmapData.draw(target2BitmapData, HitTest.getDrawMatrix(target2, hitRectangle, accurracy), new ColorTransform(1, 1, 1, 1, 255, 255, 255, 255), BlendMode.DIFFERENCE);

      // Find the intersection.
      var intersection:Rectangle = bitmapData.getColorBoundsRect(0xFFFFFFFF, 0xFF00FFFF);

      testBitmapData.dispose();
      bitmapData.dispose();

      // Alter width and positions to compensate for accurracy
      if (accurracy != 1) {
        intersection.x /= accurracy;
        intersection.y /= accurracy;
        intersection.width /= accurracy;
        intersection.height /= accurracy;
      }

      intersection.x += hitRectangle.x;
      intersection.y += hitRectangle.y;

      return intersection;
    }


    protected static function getDrawMatrix(target:DisplayObject, hitRectangle:Rectangle, accurracy:Number):Matrix {
      var localToGlobal:Point;
      var matrix:Matrix;

      // not sure how to get the root concatened Matrix
      var rootConcatenatedMatrix:Matrix = new Matrix;
      localToGlobal = target.localToGlobal(new Point());
      matrix = target.transformationMatrix;
      matrix.tx = localToGlobal.x - hitRectangle.x;
      matrix.ty = localToGlobal.y - hitRectangle.y;

      matrix.a = matrix.a / rootConcatenatedMatrix.a;
      matrix.d = matrix.d / rootConcatenatedMatrix.d;
      if (accurracy != 1)
        matrix.scale(accurracy, accurracy);

      return matrix;
    }

    public static function simpleHitTestObject(target1:DisplayObject, target2:DisplayObject):Boolean {
      return target1.getBounds(target1.parent).intersects(target2.getBounds(target2.parent));
    }

  }

}
