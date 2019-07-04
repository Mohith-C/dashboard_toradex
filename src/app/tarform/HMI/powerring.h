/********************************************************************************
*
* Name:  powerring.h
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*           Power Ring
*
*
* Author	Nibedit Dey
* Date      06 May 2019
********************************************************************************/

#ifndef POWERRING_H
#define POWERRING_H

#include <QtQuick/QQuickPaintedItem>
#include <QColor>
#include <QLinearGradient>


class PowerRing: public QQuickPaintedItem
{
        Q_OBJECT
        Q_PROPERTY(int startAngle READ getStartAngle WRITE setStartAngle)
        Q_PROPERTY(int spanAngle READ getSpanAngle WRITE setSpanAngle NOTIFY spanAngleChanged)
        Q_PROPERTY(int thickness READ getThickness WRITE setThickness)

    private:
        int m_startAngle = 0;
        int m_spanAngle = 0;
        int m_thickness = 0;
        QLinearGradient m_gradient;
        QRectF m_rect;

    signals:
        int spanAngleChanged(int spanAngle);

    public:
        PowerRing(QQuickItem *parent = Q_NULLPTR);

        int getStartAngle() const;
        Q_INVOKABLE void setStartAngle(int startAngle);

        int getSpanAngle() const;
        Q_INVOKABLE void setSpanAngle(int spanAngle);

        int getThickness() const;
        void setThickness(int thickness);

        void paint(QPainter* painter);


    protected:
        virtual void geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry);
    private:
        QPainter *m_painter = nullptr;
};

#endif // POWERRING_H
