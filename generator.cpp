#include "generator.h"
#include "SimplexNoise/src/SimplexNoise.h"
#include <QDebug>

Generator::Generator(QObject *parent)
    : QObject{parent}
{
}

QVector<QPointF> Generator::getData()
{
    QVector<QPointF> data;
    for(int i = 0; i < width; ++i)
    {
        float val = (i + time) / 100;
        float y = SimplexNoise::noise(val);
        y += SimplexNoise::noise((i + time) / 500);
        data.append(QPointF(i, y));
    }
    return data;
}

void Generator::setTime(qreal time)
{
    this->time = time;
    emit dataChanged();
}
