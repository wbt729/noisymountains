#include "mountaingenerator.h"
#include <ctime>

constexpr int maxHeightVariation = 100;

constexpr int maxSlopeXOffset = 80;
constexpr int maxSlopeYOffset = 80;

constexpr int maxRidgeMidPointXOffset = 80;
constexpr int maxRidgeMidPointYOffset = 80;

constexpr float speed = 1.2f;
constexpr float spawnProbability = 0.008f;
constexpr int minSpawnInterval = 20.;
constexpr int maxSpawnInterval = 50.;

MountainGenerator::MountainGenerator(QObject *parent)
    : Generator{parent}
{
    std::srand(std::time(0));
    Mountain* mountain = new Mountain;
    mountain->setX(width + mountain->width * 1.5);
    mountains.append(new Mountain);
}

void MountainGenerator::setTime(qreal time)
{
    this->time = time;
    qDebug() << time;

    for(int i = mountains.size() - 1; i >= 0; --i)
    {
        mountains[i]->setX(mountains[i]->getX() - speed);
    }

//    if(std::rand() < ((float) RAND_MAX * spawnProbability))
//    {
//        qDebug() << "add mountain";
//        int maxHeight = 200;
//        int minHeight = 120;

//        qreal height = minHeight + std::rand() % maxHeight + 1 - minHeight;
//        qreal width = height / 2;
//        Mountain* mountain = new Mountain;
//        mountain->setX(width + mountain->width * 1.5);
//        mountains.append(mountain);
//    }

    if(this->time >= nextSpawnTime)
    {
        qDebug() << "add mountain";
        int maxHeight = 200;
        int minHeight = 120;

        qreal height = minHeight + std::rand() % maxHeight + 1 - minHeight;
        qreal width = height / 2;
        Mountain* mountain = new Mountain;
        mountain->setX(width + mountain->width * 1.5);
        mountains.append(mountain);

        qreal interval = minSpawnInterval + std::rand() % maxSpawnInterval + 1 - minSpawnInterval;
        nextSpawnTime = this->time + interval;
    }
}

Mountain::Mountain(QObject *parent)
{
    width = 600;
    height = 300 + std::rand() % maxHeightVariation;

    outline.append(QPointF(0, 0));
    qreal leftSlopeXOffset = std::rand() % maxSlopeXOffset - maxSlopeXOffset / 2;
    qreal leftSlopeYOffset = std::rand() % maxSlopeXOffset - maxSlopeYOffset / 2;
    outline.append(QPointF(width / 4 + leftSlopeXOffset, height / 2 + leftSlopeYOffset));
    outline.append(QPointF(width / 2, height));
    qreal rightSlopeXOffset = std::rand() % maxSlopeXOffset - maxSlopeXOffset / 2;
    qreal rightSlopeYOffset = std::rand() % maxSlopeXOffset - maxSlopeYOffset / 2;
    outline.append(QPointF(3 * width / 4 + rightSlopeXOffset, height / 2 + rightSlopeYOffset));
    outline.append(QPointF(width, 0));

    ridge.append(outline.at(2));
    qreal ridgeMidpointX = ridge.at(0).x() + std::rand() % maxRidgeMidPointXOffset - maxRidgeMidPointXOffset / 2;
    qreal ridgeMidpointY = height / 2 + std::rand() % maxRidgeMidPointYOffset - maxRidgeMidPointYOffset / 2;
    ridge.append(QPointF(ridgeMidpointX, ridgeMidpointY));
    qreal ridgeBaseX = width / 2 + std::rand() % (int) (width / 2) - width / 2;
    ridge.append(QPointF(ridgeBaseX, 0));

    qreal x, y;
    // left
    x = (outline[2].x() + outline[1].x()) / 2;
    y = (outline[1].y() + outline[2].y()) / 2;
    snow.append(QPointF(x, y));

    x = ((outline[2].x() + outline[1].x()) / 2 +
            (ridge[0].x() + ridge[1].x()) / 2) / 2 + std::rand() % 20 - 10;
    y = ((outline[1].y() + outline[2].y()) / 2 + (ridge[0].y() + ridge[1].y()) / 2) / 2 -
            std::rand() % 20;
    snow.append(QPointF(x, y));

    // ridge
    x = (ridge[0].x() + ridge[1].x()) / 2;
    y = (ridge[0].y() + ridge[1].y()) / 2;
    snow.append(QPointF(x, y));

    x = ((outline[2].x() + outline[3].x()) / 2 +
            (ridge[0].x() + ridge[1].x()) / 2) / 2 + std::rand() % 20 - 10;
    y = ((outline[1].y() + outline[2].y()) / 2 + (ridge[0].y() + ridge[1].y()) / 2) / 2 -
            std::rand() % 20;
    snow.append(QPointF(x, y));

    // right
    x = (outline[2].x() + outline[3].x()) / 2;
    y = (outline[2].y() + outline[3].y()) / 2;
    snow.append(QPointF(x, y));
}
