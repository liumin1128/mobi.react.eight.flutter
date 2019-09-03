import 'package:flutter/cupertino.dart';
import 'package:eight/components/Lazyload/Image.dart';
import 'package:eight/utils/common.dart';

int width = 200;

multiPictureView(pictures) {
  // Transform(
  //     transform: Matrix4.translationValues(10, -10, 0),
  //     child: new Container(),
  //   );

  if (pictures.length >= 9) {
    List<Widget> list = [];

    for (var i in pictures) {
      list.add(
        LazyloadImage(
          borderRadius: BorderRadius.circular(4),
          color: Color(0x05000000),
          image: getSmallImg(i, width, width),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(2),
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.count(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: list,
        ),
      ),
    );
  }

  if (pictures.length == 1) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: EdgeInsets.all(2),
        child: LazyloadImage(
          borderRadius: BorderRadius.circular(4),
          color: Color(0x05000000),
          image: getSmallImg(pictures[0], width * 3, width * 3),
        ),
      ),
    );
  }

  if (pictures.length == 2) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1 / 2,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: LazyloadImage(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0x05000000),
                  image: getSmallImg(pictures[0], width * 1.5, width * 3),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(children: <Widget>[
              AspectRatio(
                aspectRatio: 1 / 2,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: LazyloadImage(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0x05000000),
                    image: getSmallImg(pictures[1], width * 1.5, width * 3),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  if (pictures.length == 3) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1 / 2,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: LazyloadImage(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0x05000000),
                  image: getSmallImg(pictures[0], width * 1.5, width * 3),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: LazyloadImage(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0x05000000),
                    image: getSmallImg(pictures[1], width * 1.5, width * 1.5),
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: LazyloadImage(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0x05000000),
                    image: getSmallImg(pictures[2], width * 1.5, width * 1.5),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  if (pictures.length == 4) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: LazyloadImage(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0x05000000),
                  image: getSmallImg(pictures[0], width * 2, width * 3),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: LazyloadImage(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0x05000000),
                    image: getSmallImg(pictures[1], width, width),
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: LazyloadImage(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0x05000000),
                    image: getSmallImg(pictures[2], width, width),
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: LazyloadImage(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0x05000000),
                    image: getSmallImg(pictures[3], width, width),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  if (pictures.length == 5) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[0], width * 2, width * 2),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1 / 2,
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: LazyloadImage(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0x05000000),
                        image: getSmallImg(pictures[1], width, width * 2),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[2], width, width),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[3], width, width),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[4], width, width),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  if (pictures.length == 6) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[0], width * 2, width * 2),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: LazyloadImage(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0x05000000),
                        image: getSmallImg(pictures[1], width, width),
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: LazyloadImage(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0x05000000),
                        image: getSmallImg(pictures[2], width, width),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[3], width, width),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[4], width, width),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[5], width, width),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  if (pictures.length == 7) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: AspectRatio(
                        aspectRatio: 1 / 2,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: LazyloadImage(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0x05000000),
                            image: getSmallImg(pictures[0], width, width * 2),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AspectRatio(
                        aspectRatio: 1 / 2,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: LazyloadImage(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0x05000000),
                            image: getSmallImg(pictures[1], width, width * 2),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: LazyloadImage(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0x05000000),
                        image: getSmallImg(pictures[2], width, width),
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: LazyloadImage(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0x05000000),
                        image: getSmallImg(pictures[3], width, width),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[4], width, width),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[5], width, width),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[6], width, width),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  if (pictures.length == 8) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: AspectRatio(
                        aspectRatio: 1 / 2,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: LazyloadImage(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0x05000000),
                            image: getSmallImg(pictures[0], width, width * 2),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1,
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: LazyloadImage(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0x05000000),
                              image: getSmallImg(pictures[1], width, width),
                            ),
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: LazyloadImage(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0x05000000),
                              image: getSmallImg(pictures[2], width, width),
                            ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: LazyloadImage(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0x05000000),
                        image: getSmallImg(pictures[3], width, width),
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: LazyloadImage(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0x05000000),
                        image: getSmallImg(pictures[4], width, width),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[5], width, width),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[6], width, width),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: LazyloadImage(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0x05000000),
                      image: getSmallImg(pictures[7], width, width),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // return list;
}
