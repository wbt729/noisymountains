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
        data.append(QPointF(i, SimplexNoise::noise(val)));
    }
    return data;
}
