using NUnit.Framework;

namespace CodingDojo.Assertings
{
    [TestFixture]
    public class DojoTests
    {
        [Test]
        public void Tests()
        {
          Assert.AreEqual(0, price(new [] {}));
          Assert.AreEqual(8, price(new [] {0}));
          Assert.AreEqual(8, price(new [] {1}));
          Assert.AreEqual(8, price(new [] {2}));
          Assert.AreEqual(8, price(new [] {3}));
          Assert.AreEqual(8, price(new [] {4}));
          Assert.AreEqual(8 * 2, price(new [] {0, 0}));
          Assert.AreEqual(8 * 3, price(new [] {1, 1, 1}));
          Assert.AreEqual(8 * 2 * 0.95, price(new [] {0, 1}));
          Assert.AreEqual(8 * 3 * 0.9, price(new [] {0, 2, 4}));
          Assert.AreEqual(8 * 4 * 0.8, price(new [] {0, 1, 2, 4}));
          Assert.AreEqual(8 * 5 * 0.75, price(new [] {0, 1, 2, 3, 4}));
          Assert.AreEqual(8 + (8 * 2 * 0.95), price(new [] {0, 0, 1}));
          Assert.AreEqual(2 * (8 * 2 * 0.95), price(new [] {0, 0, 1, 1}));
          Assert.AreEqual((8 * 4 * 0.8) + (8 * 2 * 0.95), price(new [] {0, 0, 1, 2, 2, 3}));
          Assert.AreEqual(8 + (8 * 5 * 0.75), price(new [] {0, 1, 1, 2, 3, 4}));
          Assert.AreEqual(2 * (8 * 4 * 0.8), price(new [] {0, 0, 1, 1, 2, 2, 3, 4}));
          Assert.AreEqual(3 * (8 * 5 * 0.75) + 2 * (8 * 4 * 0.8), price(new [] {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4}));
        }
    }
}