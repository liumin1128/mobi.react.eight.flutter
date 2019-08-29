import 'package:flutter/cupertino.dart';
import 'package:eight/components/Lazyload/Image.dart';

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
          image: i,
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
          image: pictures[0],
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
                  image: pictures[0],
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
                    image: pictures[1],
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
                  image: pictures[0],
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
                    image: pictures[1],
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
                    image: pictures[2],
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
                  image: pictures[0],
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
                    image: pictures[1],
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
                    image: pictures[2],
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
                    image: pictures[3],
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
                      image: pictures[0],
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
                        image: pictures[1],
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
                      image: pictures[2],
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
                      image: pictures[3],
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
                      image: pictures[4],
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
                      image: pictures[0],
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
                        image: pictures[1],
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
                        image: pictures[2],
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
                      image: pictures[3],
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
                      image: pictures[4],
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
                      image: pictures[5],
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
                            image: pictures[0],
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
                            image: pictures[1],
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
                        image: pictures[2],
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
                        image: pictures[3],
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
                      image: pictures[4],
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
                      image: pictures[5],
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
                      image: pictures[6],
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
                            image: pictures[0],
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
                              image: pictures[1],
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
                              image: pictures[2],
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
                        image: pictures[3],
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
                        image: pictures[4],
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
                      image: pictures[5],
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
                      image: pictures[6],
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
                      image: pictures[7],
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