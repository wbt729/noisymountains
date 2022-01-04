#pragma once

#include <QObject>
#include <QPointF>
#include <QDebug>
#include "generator.h"

class Mountain : public QObject
{
    Q_OBJECT

    Q_PROPERTY(qreal width MEMBER width)
    Q_PROPERTY(qreal height MEMBER height)
    Q_PROPERTY(qreal x READ getX)
    Q_PROPERTY(QList<QPointF> outline READ getOutline)
    Q_PROPERTY(QList<QPointF> ridge READ getRidge)
    Q_PROPERTY(QList<QPointF> snow READ getSnow)

public:
    explicit Mountain(QObject* parent = nullptr);
    Q_INVOKABLE QList<QPointF> getOutline() { return outline; }
    Q_INVOKABLE QList<QPointF> getRidge() { return ridge; }
    Q_INVOKABLE QList<QPointF> getSnow() { return snow; }
    Q_INVOKABLE qreal getX() { return x; }
    void setX(qreal x) { this->x = x; }
    qreal width;
    qreal height;

private:
    QList<QPointF> outline;
    QList<QPointF> ridge;
    QList<QPointF> snow;
    qreal x;
};

Q_DECLARE_METATYPE(Mountain*)

class MountainGenerator : public Generator
{
    Q_OBJECT
    Q_PROPERTY(QVector<Mountain*> mountains READ getMountains)
public:
    explicit MountainGenerator(QObject *parent = nullptr);

    Q_INVOKABLE QVector<Mountain*> getMountains() { return mountains; }
    Q_INVOKABLE void setTime(qreal time) override;

signals:

private:
    QVector<Mountain*> mountains;

    float nextSpawnTime = 0;
};
