#pragma once

#include <QObject>
#include <QPointF>
#include <QDebug>

class Generator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<QPointF> data READ getData NOTIFY dataChanged)
    Q_PROPERTY(qint16 width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(qreal time READ getTime WRITE setTime NOTIFY timeChanged)

public:
    explicit Generator(QObject *parent = nullptr);

    Q_INVOKABLE virtual QVector<QPointF> getData();
    Q_INVOKABLE void setWidth(qint16 width) { this->width = width; emit widthChanged(); }
    Q_INVOKABLE virtual void setTime(qreal time);
    Q_INVOKABLE qreal getTime() { return time; }

signals:
    void widthChanged();
    void timeChanged();
    void dataChanged();

protected:
    qint16 width = 0;
    qreal time = 0;
    QVector<QPointF> data; // unused
};
